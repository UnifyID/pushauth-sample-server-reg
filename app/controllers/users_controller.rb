class UsersController < ApplicationController
  skip_before_action :authorized
  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :password))

    if @user.save
      redirect_to root_path, notice: "Successfully created account!"
    else
      render :new and return
    end
  end
end
