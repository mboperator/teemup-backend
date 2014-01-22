# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  name          :text             not null
#  description   :text
#  created_by_id :integer          not null
#  group_id      :integer
#  location_id   :integer          not null
#  start_time    :datetime         not null
#  duration      :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Event < ActiveRecord::Base
  belongs_to :created_by, class_name: "User"
  belongs_to :group
  belongs_to :location
end
