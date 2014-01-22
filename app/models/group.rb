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
  has_many :group_memberships
  has_many :events
  has_many :admin_memberships, -> { merge(GroupMembership.admins) }, class_name: 'GroupMembership'
  has_many :admins, through: :admin_memberships, source: :user
  has_many :users, through: :group_memberships
  belongs_to :created_by, class_name: "User"

  def grab_membership(user)
    group_memberships.find_by(user: created_by)
  end

end
