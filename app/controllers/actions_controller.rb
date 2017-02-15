class ActionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_room_presence

  def create
    @action = Action.new(action_params)
    if @action.save
      redirect_to :back, notice: "Action \"#{@action.name}\" has been successfully created"
    else
      redirect_to :back, alert: 'There was an error creating this action!'
    end
  end

  private

  def action_params
    params.require(:new_action).permit(:name)
  end
end
