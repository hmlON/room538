class DashboardController < ApplicationController
  def index
    @room = current_user.room
    @users = @room.users
    @actions = @room.actions
  end
end
