class UsersController < ApplicationController
  skip_before_filter :authorize
  http_basic_authenticate_with name: "shin", password: "marcusisthebest"

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to users_path
    else
      render "new", layout: "account"
    end
  end

  private
  def user_params
    params
      .require(:user)
      .permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone_number)
  end
end
