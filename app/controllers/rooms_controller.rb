class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_room_presence, only: [:edit, :update, :destroy]
  before_action :require_room_absence, only: [:index, :new, :create]
  before_action :set_room, only: [:edit, :update, :destroy]

  def index
    @rooms = Room.includes(:users).all
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.build_room(room_params)
    if @room.save
      current_user.join_room(@room)
      redirect_to dashboard_path, notice: "You have successfully created new room \"#{@room.name}\"."
    else
      render :new
    end
  end

  def edit; end

  def update
    if RoomUpdater.new(@room, room_params).update
      redirect_to dashboard_path, notice: 'You have successfully updated your room.'
    else
      render :edit
    end
  end

  def leave
    room = current_user.room
    current_user.leave_room
    room.destroy if room.users.count.zero?
    redirect_to root_path
  end

  private

  def set_room
    @room = current_user.room
  end

  def room_params
    params.require(:room).permit(:name, action_ids: [])
  end
end
