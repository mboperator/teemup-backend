module Api
  module v1
    class GroupsController < ApiController
      responds_to :json

      # GET /groups
      # GET /groups.json
      def index
        @user = current_user
        @groups = current_user.groups

        respond_to do |format|
          format.html # index.html.haml
          format.json { render json: @groups }
        end
      end

      # GET /groups/1
      # GET /groups/1.json
      def show
        @group = Group.find_by(id: params[:id])
        if current_user.groups.include?(@group)
          respond_to do |format|
            format.html # show.html.haml
            format.json { render json: @group }
          end
        else

        end
      end

      # POST /groups
      # POST /groups.json
      def create
        @group = Group.new(group_params)
        @group.creator = current_user


        respond_to do |format|
          if @group.save
            format.json { render json: @group, status: :created, location: @group }
          else
            format.json { render json: @group.errors, status: :unprocessable_entity }
          end
        end
      end

      # PUT /groups/1
      # PUT /groups/1.json
      def update
        @group = Group.new(params[:group])

        respond_to do |format|
          if @group.update_attributes(group_params)
            format.json { head :no_content }
          else
            format.json { render json: @group.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /groups/1
      # DELETE /groups/1.json
      def destroy
        @group = Group.find_by(params[:id])
        @group.destroy

        respond_to do |format|
          format.json { head :no_content }
        end
      end

      private
      def group_params
        params.require(:group).permit(:name, :creator)
      end
    end
  end
end
