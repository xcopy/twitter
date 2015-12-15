class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  before_action only: [:show, :following, :followers] do
    @user = User.includes(:statuses).friendly.find(params[:id])
  end

  def following
    @following = @user.following
  end

  def followers
    @followers = @user.followers
  end

  def who_to_follow
    @who_to_follow = current_user.who_to_follow

    respond_to do |format|
      format.html
      format.json {render json: @who_to_follow.take(5)}
    end
  end
end
