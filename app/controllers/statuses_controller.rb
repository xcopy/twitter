class StatusesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @user = User.friendly.find(params[:user_id])
    @status = @user.statuses.find(params[:id])
  end
end
