class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_room_presence

  def create
    activity = Activity.new(activity_params)
    if activity.save
      redirect_to dashboard_path, notice: "Good job, #{current_user.name}, for \"#{activity.name}\"!"
    else
      redirect_to dashboard_path, alert: activity.errors.full_messages.join(', ')
    end
  end

  def destroy
    activity = Activity.find(params[:id])
    if activity.destroy
      redirect_to dashboard_path, notice: "Undone #{activity.name} successfully"
    else
      redirect_to dashboard_path, alert: activity.errors.full_messages.join(', ')
    end
  end

  private

  def activity_params
    params.require(:activity)
          .permit(:room_activity_id)
          .merge(user_id: current_user.id)
  end
end
