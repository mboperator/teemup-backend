module Api
  module V1
    class GroupsController < ApiController

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
        @group.created_by = current_user
        if @group.save
          @group.users << current_user
          @group.grab_membership(current_user).make_admin
          @group.grab_membership(current_user).make_confirm
          render json: { success: true }, status: :ok
        else
          render json: {success: false}, status: :unprocessable_entity
        end
      end

      def update
        @group = Group.find_by(id: params[:id])

        if @group.update_attributes(group_params)
          respond_with @group
        else
          render json: {success: false}, status: :unprocessable_entity
        end
      end

      def destroy
        @group = Group.find_by(id: params[:id])
        @group.destroy
        render json: { success: true }, status: :accepted
      end

      private
      def group_params
        params
          .require(:group)
          .permit(:name, :created_by, :description)
      end

    end
  end
end
