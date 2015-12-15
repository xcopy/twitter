class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  before_action only: [:show, :following, :followers] do
    @user = User.includes(:statuses).friendly.find(params[:id])
  end

  def following
    @following = @user.following
  end

  def followers
    @followers = @user.followers
  end
end
