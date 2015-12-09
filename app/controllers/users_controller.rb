class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @user = User.includes(:statuses).find_by_screen_name!(params[:id])
  end
end
