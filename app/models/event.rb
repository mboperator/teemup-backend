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
  accepts_nested_attributes_for :location

  has_many :event_invites
  has_many :users, through: :event_invites

  has_many :confirmed_event_invites, -> { merge(EventInvite.confirmed) }, class_name: 'EventInvite'
  has_many :confirmed_users, through: :confirmed_event_invites, source: :user

  has_many :admin_invites, -> { merge(EventInvite.admins) }, class_name: 'EventInvite'
  has_many :admin_users, through: :admin_invites, source: :user

  def end_time
    start_time + duration
  end

end
