class EventsController < ApplicationController

  def index
    @events = @group.events
  end

  def create
    loc = Location.find_or_create_by(location_params)
    @event = Event.new(event_params
                      .merge(created_by_id: current_user.id)
                      .merge(location_id: loc.id)
                      .merge(group_id: current_group.id))
    if @event.save
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
    loc = Location.find_or_create_by(location_params) if location_params
    if @event.update_attributes(event_params
                                .merge(location_id: loc.id))
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
    .permit(:name, :subtitle, :creator, :start_time, :duration)

  end

  def location_params
    params.require(:location)
    .permit(:lat, :lon)
  end
end

