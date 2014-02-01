class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :start_time, :duration_in_minutes, :lat, :lon

  def created_by
    object.created_by.name.full_name
  end

  def lat
    object.location.lat
  end

  def lon
    object.location.lon
  end

  def duration_in_minutes
    object.duration/60
  end

end