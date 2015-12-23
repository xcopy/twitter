class HomeController < ApplicationController
  def index
    @feed = current_user.feed.page(params[:page])
  end
end
