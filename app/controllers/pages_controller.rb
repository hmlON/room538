class PagesController < ApplicationController
  def index
    if !user_signed_in?
      render :user_not_signed_in, layout: false
    elsif !current_user.room?
      render :user_has_no_room
    end
  end
end
