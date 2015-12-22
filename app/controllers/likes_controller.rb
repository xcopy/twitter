class LikesController < ApplicationController
  before_action do
    user = User.friendly.find(params[:user_id])
    @status = user.statuses.find(params[:id])
  end

  def create
    current_user.like(@status)
  end

  def destroy
    current_user.unlike(@status)
  end
end
