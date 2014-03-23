class ApplicationController < ActionController::Base
  include SessionsHelper

  before_filter :authorize
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authorize
    if signed_in?
      @user = current_user
    else
      store_location
      redirect_to signout_path, notice: "Please sign in" and return
    end
  end

  private
  def ensure_admin
    redirect_to users_path  unless current_user.admin?(@group)
  end

end

