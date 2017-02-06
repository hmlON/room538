class RoomRequestsController < ApplicationController
  before_action :set_request, only: [:accept, :destroy]

  def index
    @requests_to_room = current_user.room.room_requests if current_user.room?
    @sent_requests = current_user.sent_room_requests
  end

  def accept
    sender = User.find(@request.sender_id)
    sender.join_room(current_user.room)
    redirect_to dashboard_path, notice: "#{sender.name} successfully joined your room."
  end

  def create
    request = RoomRequest.new(request_params)
    request.sender = current_user
    if request.save
      redirect_to room_requests_path, notice: 'Request successfully sent.'
    else
      redirect_to rooms_path, alert: 'There was an error sending your request'
    end
  end

  def destroy
    if @request.destroy
      redirect_to room_requests_path, notice: 'Request successfullt deleted.'
    else
      redirect_to room_requests_path, alert: 'There was an error deleting your request'
    end
  end

  private

  def set_request
    @request = RoomRequest.find(params[:id])
  end

  def request_params
    params.require(:room_request).permit(:room_id)
  end
end
