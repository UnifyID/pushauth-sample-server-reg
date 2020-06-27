class SessionsController < ApplicationController
  skip_before_action :authorized, except: [:destroy]

  before_action :semi_authorized!, only: [:init_2fa, :check_2fa, :finalize_2fa]

  def new
    redirect_to root_path if logged_in?
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:pre_2fa_user_id] = @user.id

      pushauth_title = "Authenticate with #{Rails.application.class.module_parent.to_s}?"
      pushauth_body = "Login request from #{request.remote_ip}"

      response = PushAuth.create_session(@user.username, pushauth_title, pushauth_body)

      session[:pushauth_id] = response["id"]

      redirect_to action: "init_2fa"
    else
      redirect_to login_path, alert: "Sorry, that didn't work."
    end
  end

  def check_2fa
    status = PushAuth.get_session_status(session[:pushauth_id])["status"]

    render plain: status
  end

  def finalize_2fa
    case PushAuth.get_session_status(session[:pushauth_id])["status"]
    when "accepted"
      session[:user_id] = session[:pre_2fa_user_id]
      session[:pushauth_id] = nil
      session[:pre_2fa_user_id] = nil
      flash.notice = "Successfully logged in!"
    when "rejected"
      session[:pre_2fa_user_id] = nil
      flash.alert = "Your request was denied."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Successfully logged out."
  end

  private
  def semi_authorized
    session[:pre_2fa_user_id] && session[:pushauth_id]
  end

  def unauthorized
    redirect_to login_path, alert: "You are not authorized to view this page."
  end

  def semi_authorized!
    unauthorized unless semi_authorized
  end
end
