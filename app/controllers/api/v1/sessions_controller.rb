module Api
  module V1
    class SessionsController < ApiController
      skip_before_filter :api_authorize, only: :create
      include ApiHelper

      respond_to :json

      def create
        user = User.find_by(email: params[:user][:email].downcase)
        if user && user.authenticate(params[:user][:password])
          set_user(user)
          render json: { apikey: user.api_keys.first.access_token, user_id: user.id, success: true }, status: :created
        else
          render json: { errors: user.errors, success: false },  status: :bad_request
        end
      end
      
      private
      def user_params
        params
          .require(:user)
          .permit(:email, :password)
      end
    end
  end
end
