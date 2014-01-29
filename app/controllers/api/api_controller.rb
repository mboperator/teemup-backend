class Api::ApiController < ApplicationController
  before_filter :api_authorize
  skip_before_filter :verify_authenticity_token, except: [:create]
  include ApiHelper

  respond_to :json

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      set_user(user)
      render json: { apikey: user.api_keys.first.access_token, user_id: user.id, success: true }, status: :created
    else
      render json: { errors: user.errors, success: false },  status: :bad_request
    end
  end

  private
  def api_authorize
    authenticate_or_request_with_http_token do |token , options|
      user = ApiKey.find_by(access_token: token).try(:user)
      if user
        set_user(user)
      else
        head :unauthorized
      end
    end
  end
end
