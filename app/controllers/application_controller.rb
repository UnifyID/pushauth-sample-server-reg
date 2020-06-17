class ApplicationController < ActionController::Base
  before_action :authorized
  helper_method :current_user
  helper_method :logged_in?

  skip_before_action :authorized, only: [:home]

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def authorized
    unless logged_in?
      flash.alert = "You must be logged in to perform that action."
      redirect_to "/login"
    end
  end

  def home
  end

  def restricted
  end
end
