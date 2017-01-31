class PagesController < ApplicationController
  def index
    if !user_signed_in?
      render :user_not_signed_in
    elsif !current_user.room?
      render :user_has_no_room
    else
      redirect_to rooms_path
    end
  end
end
