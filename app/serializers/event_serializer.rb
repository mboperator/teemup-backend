class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :start_time, :duration_in_minutes, :lat, :lon, :location_name, :event_tags


  def lat
    object.location.lat
  end

  def lon
    object.location.lon
  end

  def duration_in_minutes
    object.duration/60
  end

  def event_tags
    object.tags.pluck(:name)
  end

end
