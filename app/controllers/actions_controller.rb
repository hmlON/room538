class ActionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @action = Action.new(action_params)
    if @action.save
      redirect_to :back, notice: "Action \"#{@action.name}\" has been successfully created"
    else
      redirect_to :back, alert: 'There was an error creating this action!'
    end
  end

  def destroy
    action = Action.find(params[:id])
    if action.destroy
      redirect_to :back, notice: "Action \"#{action.name}\" has been successfully deleted"
    else
      redirect_to :back, alert: 'There was an error deleting this action!'
    end
  end

  private

  def action_params
    params.require(:new_action)
          .permit(:name)
          .tap { |params| params[:creator_id] = current_user.id }
  end
end