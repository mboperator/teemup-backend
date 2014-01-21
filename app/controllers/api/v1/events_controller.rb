module Api
  module v1
    class EventsController < ApiController
      responds_to :json

      # GET /group/:group_id/events.json
      def index
        @group = Group.find_by(id: params[:group_id])
        @events = @group.events

        respond_to do |format|
          format.html # index.html.haml
          format.json { render json: @events }
        end
      end

      # GET /group/:group_id/events/:id.json
      def show
        @event = Event.find_by(id: params[:id])

        respond_to do |format|
          format.html # show.html.haml
          format.json { render json: @event }
        end
      end

      # POST /group/:group_id/events.json
      def create
        @event = Event.new(event_params)
        @event.creator = current_user
        @event.group = Group.find_by(params[:group_id])


        respond_to do |format|
          if @event.save
            format.json { render json: @event, status: :created, location: @event }
          else
            format.json { render json: @event.errors, status: :unprocessable_entity }
          end
        end
      end

      # PUT /group/:group_id/events/:id.json
      def update
        @event = Event.new(params[:event])

        respond_to do |format|
          if @event.update_attributes(event_params)
            format.json { head :no_content }
          else
            format.json { render json: @event.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /group/:group_id/events/:id.json
      def destroy
        @event = Event.find_by(params[:id])
        @event.destroy

        respond_to do |format|
          format.json { head :no_content }
        end
      end

      private
      def event_params
        params.require(:event).permit(:name, :subtitle, :creator, :location => { :lat, :lon })
      end

    end
  end
end
