class LocationSerializer < ActiveModel::Serializer
  attributes :id, :lat, :lon
  has_many :events
  has_many :users
end
