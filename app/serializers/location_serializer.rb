class LocationSerializer < ActiveModel::Serializer
  attributes :id, :lat, :lon, :events, :users

  def events
    object.events
  end

  def users
    object.users
  end

end
