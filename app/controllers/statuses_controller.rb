class StatusesController < ApplicationController
  def show
    @user = User.find_by!(screen_name: params[:user_id])
    @status = @user.statuses.find(params[:id])
  end
end
