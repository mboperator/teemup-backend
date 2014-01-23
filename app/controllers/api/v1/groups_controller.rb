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
        group = Group.new(group_params.merge(created_by_id: current_user.id))
        if group.save
          current_user.group_memberships.create(group_id: group.id, is_admin: true, is_confirmed: true)
          head :ok
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
        Group.find_by(id: params[:id]).destroy
        render json: { success: true }, status: :accepted
      end

      private
      def group_params
        params
          .require(:group)
          .permit(:name, :created_by_id, :description)
      end

    end
  end
end
