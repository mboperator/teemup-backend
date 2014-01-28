module Api
  module V1
    class FriendshipsController < ApiController

      def index
        respond_with current_user.friends
      end

      def create
        friendship = Friendship.new(user_id: current_user.id, friend_id: User.find_by(friendship_params).id)
        if friendship.save
          head :ok
        else
          render json: {success: false}, status: :unprocessable_entity
        end
      end

      def update
        @friendship = Friendship.find_by(friend_id: params[:id])
        if @friendship.update_attributes(friendship_params)
          render json: {success: true}, status: :accepted
        else
          render json: {success: false}, status: :unprocessable_entity
        end
      end

      def destroy
        Friendship.find_by(friend_id: params[:id]).destroy
        render json: { success: true }, status: :accepted
      end

      private
      def friendship_params
        params.permit(:phone_number, :is_confirmed)
      end

    end
  end
end
