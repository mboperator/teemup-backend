module Api
  module V1
    class UsersController < ApiController
      skip_before_filter :api_authorize, only: :create
      respond_to :json

      def create
        user = User.new(user_params)
        if user.save
          render json: user.api_keys.first.access_token
        else
          render json: { success: false }, status: :bad_request
        end
      end

      private
      def user_params
        params
          .require(:user)
          .permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone_number)
      end
    end
  end
end
