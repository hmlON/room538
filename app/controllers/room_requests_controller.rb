class RoomRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_room_absence, only: [:create]
  before_action :set_request, only: [:accept, :destroy]

  def index
    @requests_to_room = current_user.room.room_requests if current_user.room?
    @sent_requests = current_user.sent_room_requests
  end

  def accept
    @request.sender.join_room(current_user.room)
    redirect_to dashboard_path, notice: "#{@request.sender.name} successfully joined your room."
  end

  def create
    if RoomRequest.exists?(room_id: request_params[:room_id])
      redirect_to room_requests_path, alert: 'You already sent request to that room'
      return
    end
    request = RoomRequest.new(request_params)
    if request.save
      redirect_to room_requests_path, notice: 'Request successfully sent.'
    else
      redirect_to rooms_path, alert: 'There was an error sending your request'
    end
  end

  def destroy
    if @request.destroy
      redirect_to room_requests_path, notice: 'Request successfully deleted.'
    else
      redirect_to room_requests_path, alert: 'There was an error deleting your request'
    end
  end

  private

  def set_request
    @request = RoomRequest.find(params[:id])
    require_request_ownership
  end

  def require_request_ownership
    redirect_to room_requests_path, alert: "You don't have access to this request" if @request.sender != current_user &&
                                                                                      @request.room != current_user.room
  end

  def request_params
    request_params = params.require(:room_request).permit(:room_id)
    request_params[:sender_id] = current_user.id
    request_params
  end
end
