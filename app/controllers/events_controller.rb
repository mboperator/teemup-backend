class EventsController < ApplicationController

  def index
    @events = @group.events
  end

  def create
    @event = Event.new
    @event.build_location
    if @event.update_attributes(event_params)
      redirect_to group_url(@group.id), notice: 'Event was successfully created.'
    end
  end

  def new
    @event = Event.new
  end

  def show
    @event = Event.find_by(id: params[:id])
  end

  def update
    @event = Event.find_by(id: params[:id])
    if @event.update_attributes(event_params)
      redirect_to [@group, @event] , notice: 'Event was successfully updated.'
    end
  end

  def edit
    @event = Event.find_by(id: params[:id])
  end

  def destroy
    @event = Event.find_by(id: params[:id])
    @event.destroy
    redirect_to group_events_url
  end

  private
  def event_params
    params.require(:event)
          .permit(:name, :description, :created_by_id, :group_id, :start_time, :duration, location: [:lat, :lon])
  end
end

