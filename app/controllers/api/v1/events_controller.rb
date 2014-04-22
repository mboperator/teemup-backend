module Api
  module V1
    class EventsController < ApiController
      respond_to :json
      skip_before_filter :api_authorize, only: [:index, :show]

      def index
        day = 'today'
        day = params[:day] if params[:day]
        events =
          if current_group
            current_group.events.for(day).ascending
          elsif current_tag
            current_tag.events.for(day).ascending
          else
            Event.for(day).ascending
          end

        respond_with events
        end

      def show
        respond_with Event.find_by(id: params[:id]), serializer: EventDetailSerializer
      end

      def create
        loc = Location.find_or_create_by(location_params)
        event = Event.new(event_params
                          .merge(created_by_id: current_user.id)
                          .merge(location_id: loc.id)
                          .merge(group_id: current_group.id))
        if event.save
          current_user.event_invites.create(event_id: event.id, is_admin: true, is_confirmed: true)
          head :ok
        else
          render json: {success: false}, status: :unprocessable_entity
        end
      end

      def update
        @event = Event.find_by(id: params[:id])
        Location.find_by(id: @event.location_id).update_attributes(location_params) if location_params
        if @event.update_attributes(event_params)
          respond_with @event
        else
          render json: {success: false}, status: :unprocessable_entity
        end

      end

      def destroy
        @event = Event.find_by(params[:id])
        @event.destroy

        render json: { success: true }, status: :accepted
      end

      private
      def event_params
        params.require(:event)
              .permit(:name, :subtitle, :creator, :start_time, :duration, :description)

      end

      def location_params
        params.require(:location)
              .permit(:lat, :lon)
      end

    end
  end
end
