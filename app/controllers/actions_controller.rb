class ActionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_room_presence

  def new
    @action = Action.new
  end

  def create
    @action = Action.new(action_params)
    if @action.save
      redirect_to :back, notice: "Action \"#{@action.name}\" has been successfully created"
    else
      render :new
    end
  end

  private

  def action_params
    params.require(:new_action).permit(:name)
  end
end
