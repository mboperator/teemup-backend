# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  lat        :float
#  lon        :float
#  lonlat     :spatial          point, 4326
#  created_at :datetime
#  updated_at :datetime
#

class Location < ActiveRecord::Base
  has_many :users
  has_many :events
  after_save :update_lonlat

  set_rgeo_factory_for_column(:lonlat, RGeo::Geographic.spherical_factory(srid: 4326))

  scope :find_in_radius, -> (location = nil, radius_in_meters = 10) { where{st_dwithin(lonlat, location.lonlat, radius_in_meters) } }

  private
  def update_lonlat
    unless self.lonlat
      self.lonlat = Location.rgeo_factory_for_column(:lonlat).point(lon, lat)
      self.save
    end
  end

end
