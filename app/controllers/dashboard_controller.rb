class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_room_presence

  def index
    @room = Room.includes(:users, room_actions: :user_actions).where(id: current_user.room_id).first
    @activities = PublicActivity::Activity.order('created_at desc').where(owner_id: current_user.room.user_ids)
  end

  def do_action
    action = current_user.user_actions.find_by(id: params[:user_action][:id])
    action.update(value: action.value + 1)
    action.create_activity :done, owner: current_user
    redirect_to dashboard_path, notice: "Good job, #{current_user.name}!"
  end
end
