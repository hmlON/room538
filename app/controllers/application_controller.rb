class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def require_room_presence
    redirect_to root_path, alert: 'You need to have room!' unless current_user.room?
    @room = current_user.room
  end

  def require_room_absence
    redirect_to dashboard_path, alert: 'You already have a room!' if current_user.room?
  end
end
