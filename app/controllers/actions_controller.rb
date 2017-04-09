class ActionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @action = Action.new(action_params)
    if @action.save
      flash[:notice] = "Action \"#{@action.name}\" has been successfully created"
    else
      flash[:alert] = 'There was an error creating this action!'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    action = Action.find(params[:id])
    if action.destroy
      flash[:notice] = "Action \"#{action.name}\" has been successfully deleted"
    else
      flash[:alert] = 'There was an error deleting this action!'
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def action_params
    params.require(:new_action)
          .permit(:name)
          .tap { |params| params[:creator_id] = current_user.id }
  end
end
