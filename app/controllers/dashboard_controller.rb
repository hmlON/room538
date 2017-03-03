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

  def punish
    action = Action.find_by(name: 'taking out trash')
    room_action = RoomAction.find_by(action_id: action.id)
    users = User.where(id: params[:punishment][:user_ids].drop(1))

    users.each do |user|
      user_action = user.user_actions.find_by(room_action_id: room_action.id)
      user_action.update(value: user_action.value - 1)
    end

    redirect_to dashboard_path, notice: 'Roommates are successfully punished.'
  end
end
