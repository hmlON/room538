class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:join]
  before_action :require_room_presence, only: [:edit, :update, :destroy]
  before_action :require_room_absence, only: [:new, :create]
  before_action :set_room, only: [:edit, :update, :destroy]

  def index
    @rooms = Room.includes(:users).all
  end

  def new
    @actions = Action.where(creator_id: [nil, current_user.id])
    @room = Room.new
  end

  def create
    @room = current_user.build_room(room_params)
    if @room.save
      current_user.join_room(@room)
      redirect_to dashboard_path, notice: "You have successfully created new room \"#{@room.name}\"."
    else
      redirect_to new_room_path, alert: 'There was an error creating the room!'
    end
  end

  def edit
    ids = current_user.room.user_ids
    ids << nil # add default actions
    @actions = Action.where(creator_id: ids)
  end

  def update
    if RoomUpdater.new(@room, room_params).update
      redirect_to dashboard_path, notice: 'You have successfully updated your room.'
    else
      render :edit
    end
  end

  def join
    unless user_signed_in?
      return redirect_to new_user_registration_path,
                         notice: 'You need to sign in or sign up and after that follow the link again.'
    end
    if current_user.room?
      return redirect_to edit_room_path,
                         notice: 'To join another room you need to leave your current. You can do this in danger zone.'
    end
    room = Room.all.select { |room_s| room_s.invite_token == params[:token] }.first
    current_user.join_room(room)
    redirect_to dashboard_path, notice: "Welcome to room \"#{room.name}\"!"
  end

  def leave
    room = current_user.room
    current_user.leave_room
    room.destroy if room.users.count.zero?
    redirect_to root_path
  end

  def reset_progress
    room = current_user.room
    room.room_actions.flat_map(&:user_actions).each do |user_action|
      user_action.update(value: 0)
    end

    room.create_activity :resetted, owner: current_user

    redirect_to dashboard_path, notice: 'Resetted room progress successfully.'
  end

  private

  def set_room
    @room = current_user.room
  end

  def room_params
    params.require(:room).permit(:name, action_ids: [])
  end
end
