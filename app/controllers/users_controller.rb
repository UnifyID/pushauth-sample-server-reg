class UsersController < ApplicationController

  skip_before_action :authorized
  skip_before_action :verify_authenticity_token, only: :trust
  http_basic_authenticate_with name: Rails.application.credentials.unifyid[:basic_username],
    password: Rails.application.credentials.unifyid[:basic_password],
    only: :trust

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :password))

    if @user.save
      session[:signup_user] = @user.id
      session[:signup_access_code] = @user.verification_code
      redirect_to post_signup_users_path
    else
      render :new and return
    end
  end

  def post_signup
    @access_code = session[:signup_access_code]
  end

  def trust
    @user = User.find_by(username: params[:id])
    if @user && @user.consume_verification_code(params[:pairingCode].to_i)
      head :ok
    else
      head :unauthorized
    end
  end
end
