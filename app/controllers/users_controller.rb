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

  def follow
    user = User.find(params[:id])

    if current_user.following?(user)
      render status: :bad_request
    end

    current_user.follow(user)

    render json: user
  end

  def unfollow
    user = User.find(params[:id])

    unless current_user.following?(user)
      render status: :bad_request
    end

    current_user.unfollow(user)

    render json: user
  end
end
