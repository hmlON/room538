class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_room_presence

  def index
    @room = Room.includes(:users, :actions).where(id: current_user.room_id).first
    @users = @room.users
    @actions = @room.actions
  end
end
