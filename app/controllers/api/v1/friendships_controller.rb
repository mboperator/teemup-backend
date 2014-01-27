module Api
  module V1
    class FriendshipsController < ApiController

      def index
        respond_with current_user.friends
      end

      def create
        friendship = Friendship.new(friendship_params.merge(user_id: current_user.id))
        if friendship.save
          head :ok
        else
          render json: {success: false}, status: :unprocessable_entity
        end
      end

      def update
        @friendship = Friendship.find_by(id: params[:id])
        if @friendship.update_attributes(friendship_params)
          render json: {success: true}, status: :accepted
        else
          render json: {success: false}, status: :unprocessable_entity
        end
      end

      def destroy
        Friendship.find_by(id: params[:id]).destroy
        render json: { success: true }, status: :accepted
      end

      private
      def friendship_params
        params
          .require(:friendship)
          .permit(:friend_id, :is_confirmed)
      end

    end
  end
end
