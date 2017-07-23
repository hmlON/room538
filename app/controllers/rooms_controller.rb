class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:join]
  before_action :require_room_presence, only: [:edit, :update, :destroy, :leave, :reset_progress]
  before_action :require_room_absence, only: [:new, :create]

  def index
    @rooms = Room.includes(:users).all.order(:id)
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      @room.users << current_user
      @room.create_default_room_activities
      redirect_to new_room_activity_path, notice: "You have successfully created new room \"#{@room.name}\"."
    else
      redirect_to new_room_path, alert: 'There was an error creating the room!'
    end
  end

  def edit
    @room_activities = @room.room_activities.unscoped
  end

  def update
    if @room.update(room_params)
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
    room = Room.with_invite_token(params[:token])
    room.users << current_user
    redirect_to dashboard_path, notice: "Welcome to room \"#{room.name}\"!"
  end

  def leave
    room = current_user.room
    current_user.leave_room
    room.destroy if room.users.count.zero?
    redirect_to root_path
  end

  def reset_progress
    @room.activities.destroy_all

    redirect_to dashboard_path, notice: 'Resetted room progress successfully.'
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
