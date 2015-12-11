class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  before_action only: [:show, :following, :followers] do
    @user = User.includes(:statuses).find_by_screen_name!(params[:id])
  end
end
