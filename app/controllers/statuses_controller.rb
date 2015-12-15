class StatusesController < ApplicationController
  def show
    @user = User.friendly.find(params[:user_id])
    @status = @user.statuses.find(params[:id])
  end
end
