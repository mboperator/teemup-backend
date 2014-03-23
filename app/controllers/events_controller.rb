class EventsController < ApplicationController

  def index
    if @group
      @events = @group.events.where("start_time > ?", Time.now).order(:start_time)
    else
      @events = Event.where("start_time > ?", Time.now).order(:start_time)
    end

  end

  def create
    loc = Location.find_or_create_by(location_params)
    @event = Event.new(event_params
                      .merge(created_by_id: current_user.id)
                      .merge(location_id: loc.id)
                      .merge(group_id: current_group.id))
    @event.duration = @event.duration * 3600
    if @event.save
      redirect_to group_url(@group.id), notice: 'Event was successfully created.'
    end
  end

  def new
    @event = Event.new(duration: 3600)
    @event.location = default_location
  end

  def show
    @event = Event.find_by(id: params[:id])
  end

  def update
    @event = Event.find_by(id: params[:id])
    loc = Location.find_or_create_by(location_params) if location_params
    if @event.update_attributes(event_params
                                .merge(location_id: loc.id))
      @event.duration = @event.duration * 3600
      @event.save
      redirect_to [@group, @event] , notice: 'Event was successfully updated.'
    end
  end

  def edit
    @event = Event.find_by(id: params[:id])
  end

  def destroy
    @event = Event.find_by(id: params[:id])
    @event.destroy
    redirect_to group_url(current_group)
  end

  private
  def event_params
    params.require(:event)
    .permit(:name, :subtitle, :created_by_id, :group_id, :start_time, :duration, :description, :picture, :location_name, tag_ids: [])
  end

  def location_params
    params.require(:location)
    .permit(:lat, :lon)
  end

  def default_location
    Location.new(lat: 34.4155193, lon:-119.8511707)
  end
end

