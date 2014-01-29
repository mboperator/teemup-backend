module Api
  module V1
    class UsersController < ApiController
      skip_before_filter :api_authorize, only: :create

      respond_to :json

      def create
        user = User.new(user_params)
        if user.save
          render json: { apikey: user.api_keys.first.access_token, user_id: user.id, success: true }, status: :created
        else
          render json: { errors: user.errors, success: false },  status: :bad_request
        end
      end

      def update
        if current_user.update_attributes(user_params)
          render json: { success: true }, status: :accepted
        else
          render json: { success: false }, status: :bad_request
        end
      end

      def show
        respond_with current_user
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
