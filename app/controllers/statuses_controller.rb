class StatusesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  before_action only: [:show, :destroy, :favorited] do
    @user = User.friendly.find(params[:user_id])
    @status = @user.statuses.find(params[:id])
  end

  def create
    @status = current_user.statuses.create!(status_params)
  end

  def destroy
    @status.destroy!
    render nothing: true
  end

  def favorited
    render layout: false
  end

  private

  def status_params
    params.require(:status).permit(:content)
  end
end
