class Api::ApiController < ApplicationController
  before_filter :api_authorize
  skip_before_filter :verify_authenticity_token
  include ApiHelper

  respond_to :json


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
