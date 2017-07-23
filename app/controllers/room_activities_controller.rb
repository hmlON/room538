class RoomActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_room_presence

  def new
    @room_activities = @room.room_activities.unscoped
  end

  def create
    @room_activity = RoomActivity.new(room_activity_params)
    if @room_activity.save
      # redirect_to dashboard_path, notice: "RoomActivity \"#{@room_activity.name}\" has been successfully created"
      flash[:notice] = "RoomActivity \"#{@room_activity.name}\" has been successfully created"
    else
      flash[:alert] = @room_activity.errors.full_messages.join(',') # 'There was an error creating this activity!'
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    room_activity = RoomActivity.unscoped.find(params[:id])
    if room_activity.update(room_activity_params)
      render json: { ok: true }
    else
      render json: room_activity.errors
    end
  end

  def destroy
    room_activity = RoomActivity.find(params[:id])
    if room_activity.destroy
      flash[:notice] = "Activity \"#{room_activity.name}\" has been successfully deleted"
    else
      flash[:alert] = 'There was an error deleting this activity!'
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def set_room
    @room = current_user.room
  end

  def room_activity_params
    params.require(:room_activity)
          .permit(:name, :enabled)
          .merge(room_id: @room.id)
  end
end
