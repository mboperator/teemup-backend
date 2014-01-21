# == Schema Information
#
# Table name: groups
#
#  id            :integer          not null, primary key
#  name          :text             not null
#  description   :text
#  created_by_id :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Group < ActiveRecord::Base
  has_many :users, through: :group_memberships
end
