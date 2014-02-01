class SessionsController < ApplicationController
  layout "account"
  skip_before_filter :authorize, :enforce_plan_pricewalls

  def new
    redirect_to users_path if signed_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      complete_profile(user)
    else 
      flash.now[:error] = "Invalid email or password"
      render 'new'
    end
  end 

  def destroy
    sign_out
    redirect_to signin_path
  end
end
