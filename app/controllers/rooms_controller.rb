class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_room_presence, only: [:edit, :update, :destroy]
  before_action :set_room, only: [:edit, :update, :destroy]

  def index
    @rooms = Room.includes(:users).all
  end

  def new
    redirect_to rooms_path, alert: 'You already have a room!' if current_user.room?
    @room = Room.new
  end

  def create
    @room = current_user.build_room(room_params)
    if @room.save
      @room.users << current_user
      redirect_to rooms_path, notice: "You have successfully created new room \"#{@room.name}\"."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @room.update(room_params)
      redirect_to rooms_path, notice: 'You have successfully updated your room.'
    else
      render :edit
    end
  end

  def destroy
    @room.users.each do |user|
      user.update(room_id: nil)
    end
    @room.destroy
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
