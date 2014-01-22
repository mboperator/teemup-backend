module Api
  module V1
    class GroupsController < ApiController
      responds_to :json

      def index
        @user = current_user
        @groups = current_user.groups
        respond_with @groups
      end

      def show
        @group = Group.find_by(id: params[:id])
        if current_user.groups.include?(@group)
          respond_with @group
        else
          render json: { success: false }, status: :unauthorized
        end
      end

      def create
        @group = Group.new(group_params)
        @group.creator = current_user
        if @group.save
          respond_with @group
        else
          render json: {success: false}, status: :unprocessable_entity
        end
      end

      def update
        @group = Group.new(params[:group])

        if @group.update_attributes(group_params)
          respond_with @group
        else
          render json: {success: false}, status: :unprocessable_entity
        end
      end

      def destroy
        @group = Group.find_by(params[:id])
        @group.destroy
        render json: { success: true }, status: :accepted
      end

      private
      def group_params
        params
          .require(:group)
          .permit(:name, :creator)
      end

    end
  end
end
