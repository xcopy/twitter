class HomeController < ApplicationController
  def index
    @status = current_user.statuses.new
  end
end
