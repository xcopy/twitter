class ApplicationController < ActionController::Base
  helper :all

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  # @return [Boolean]
  def devise_controller?
    super
  end

  def authenticate_user!
    super
  end

  # @return [User]
  def current_user
    super
  end

  # @return [Boolean]
  def user_signed_in?
    super
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) {|u| u.permit(:login, :screen_name, :email, :password, :remember_me)}
  end
end
