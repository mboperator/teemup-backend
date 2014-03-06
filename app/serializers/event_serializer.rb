class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :start_time, :duration_in_minutes,
             :lat, :lon, :location_name, :event_tags, :pic_url


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

  def location_name
    "#{object.location_name}"
  end

  def pic_url
    "http://teemup.us#{object.picture.url(:medium)}"
  end

  def start_time
    object.start_time.in_time_zone('UTC')
  end

end
