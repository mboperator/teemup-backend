module Api
  module V1
    class EventsController < ApiController
      respond_to :json
      def index
        @group = Group.find_by(id: params[:group_id])
        respond_with @group.events
      end

      def show
        respond_with Event.find_by(id: params[:id])
      end

      def create
        @event = Event.new(event_params)
        @event.created_by = current_user
        if @event.save
          @event.group = Group.find_by(params[:group_id])
          @event.users << current_user
          @event.grab_invite.make_admin
          @event.grab_invite.make_confirm
          respond_with @event
        else
          render json: {success: false}, status: :unprocessable_entity
        end
      end

      def update
        @event = Event.find_by(params[:id])

        if @event.update_attributes(event_params)
          respond_with @event
        else
          render json: {success: false}, status: :unprocessable_entity
        end

      end

      # DELETE /group/:group_id/events/:id.json
      def destroy
        @event = Event.find_by(params[:id])
        @event.destroy

        render json: { success: true }, status: :accepted
      end

      private
      def event_params
        params.require(:event).permit(:name, :subtitle, :creator, :location => [:lat, :lon ])
      end

    end
  end
end
