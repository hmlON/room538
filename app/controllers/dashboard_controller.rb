class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_room_presence

  def index
    @room = current_user.room
    @users = @room.users
    @actions = @room.actions
  end
end
