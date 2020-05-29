class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new
    redirect_to '/' if logged_in?
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash.notice = "Successfully logged in!"
      redirect_to '/'
    else
      flash.alert = "Sorry, that didn't work."
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    flash.notice = "Successfully logged out."
    redirect_to '/'
  end
end
