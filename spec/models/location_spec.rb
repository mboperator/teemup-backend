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

require 'spec_helper'

describe Location do
  pending "add some examples to (or delete) #{__FILE__}"
end
