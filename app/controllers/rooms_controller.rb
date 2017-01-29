class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.includes(:users).all
  end

  def new
    @room = Room.new
  end

  def create
    room = Room.new(room_params)
    if room.save
      room.users << current_user
      redirect_to root_path, notice: "You successfully created new room \"#{room.name}\""
    else
      render :new
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
