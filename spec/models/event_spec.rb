# == Schema Information
#
# Table name: events
#
#  id                   :integer          not null, primary key
#  name                 :text             not null
#  description          :text
#  created_by_id        :integer          not null
#  group_id             :integer
#  location_id          :integer          not null
#  start_time           :datetime         not null
#  duration             :integer
#  created_at           :datetime
#  updated_at           :datetime
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  location_name        :string(255)
#  daily_event          :boolean          default(FALSE)
#  weekly_event         :boolean          default(FALSE)
#

require 'spec_helper'

describe Event do
  pending "add some examples to (or delete) #{__FILE__}"
end
