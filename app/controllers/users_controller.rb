class UsersController < ApplicationController
  skip_before_filter :authorize

  def new
    @user = User.new
    render layout: "account"
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

  def index
    @users = User.all
  end

  private
  def user_params
    params
      .require(:user)
      .permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone_number)
  end
end
