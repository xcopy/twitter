class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  before_action only: [:show, :following, :followers] do
    @user = User.includes(:statuses).friendly.find(params[:id])
  end

  before_action only: [:follow, :unfollow] do
    @other_user = User.find(params[:id])
  end

  def following
    @following = @user.following
  end

  def followers
    @followers = @user.followers
  end

  def who_to_follow
    @who_to_follow = current_user.who_to_follow
  end

  def follow
    if current_user.following?(@other_user)
      render status: :bad_request
    end

    current_user.follow(@other_user)
  end

  def unfollow
    unless current_user.following?(@other_user)
      render status: :bad_request
    end

    current_user.unfollow(@other_user)
  end
end
