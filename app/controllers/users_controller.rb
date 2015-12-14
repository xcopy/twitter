class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  before_action only: [:show, :following, :followers] do
    @user = User.includes(:statuses).find_by!(screen_name: params[:id])
  end

  def following
    @following = @user.following
  end

  def followers
    @followers = @user.followers
  end
end
