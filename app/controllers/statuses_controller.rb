class StatusesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @user = User.friendly.find(params[:user_id])
    @status = @user.statuses.find(params[:id])
  end

  def create
    @status = current_user.statuses.create!(status_params)
  end

  private

  def status_params
    params.require(:status).permit(:text)
  end
end
