class RoomRequestsController < ApplicationController
  def index
    @requests_to_room = current_user.room.room_requests if current_user.room?
    @sent_requests = current_user.sent_room_requests
  end

  def create
    request = RoomRequest.new(request_params)
    request.sender = current_user
    if request.save
      redirect_to rooms_path, notice: 'Request successfullt sent.'
    else
      redirect_to rooms_path, alert: 'There was an error sending your request'
    end
  end

  private

  def request_params
    params.require(:room_request).permit(:room_id)
  end
end
