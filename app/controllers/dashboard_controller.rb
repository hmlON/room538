class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_room_presence

  def index
    @activities = @room.activities.order(created_at: :desc)
  end

  def punish
    action = Action.find_by(name: 'taking out trash')
    room_action = RoomAction.find_by(action_id: action.id)
    users = User.where(id: params[:punishment][:user_ids].drop(1))

    users.each do |user|
      user_action = user.user_actions.find_by(room_action_id: room_action.id)
      user_action.update(value: user_action.value - 1)
      #  create_punishment
    end

    redirect_to dashboard_path, notice: 'Roommates are successfully punished.'
  end
end
