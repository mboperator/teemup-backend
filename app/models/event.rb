# == Schema Information
#
# Table name: events
#
#  id                        :integer          not null, primary key
#  name                      :text             not null
#  description               :text
#  created_by_id             :integer          not null
#  group_id                  :integer
#  location_id               :integer          not null
#  start_time                :datetime         not null
#  duration                  :integer
#  created_at                :datetime
#  updated_at                :datetime
#  header_image_file_name    :string(255)
#  header_image_content_type :string(255)
#  header_image_file_size    :integer
#  header_image_updated_at   :datetime
#  picture_file_name         :string(255)
#  picture_content_type      :string(255)
#  picture_file_size         :integer
#  picture_updated_at        :datetime
#  location_name             :string(255)
#

class Event < ActiveRecord::Base

  belongs_to :created_by, class_name: "User"
  belongs_to :group
  belongs_to :location
  accepts_nested_attributes_for :location

  has_many :event_invites
  has_many :users, through: :event_invites
  has_and_belongs_to_many :tags

  has_many :confirmed_event_invites, -> { merge(EventInvite.confirmed) }, class_name: 'EventInvite'
  has_many :confirmed_users, through: :confirmed_event_invites, source: :user

  has_many :admin_invites, -> { merge(EventInvite.admins) }, class_name: 'EventInvite'
  has_many :admin_users, through: :admin_invites, source: :user

  has_attached_file :picture, styles: { small: "100x100#", medium: "320x200>" }

  scope :today, -> {{conditions: ['start_time > ? AND start_time < ?', DateTime.now.utc.to_date , DateTime.now.utc.to_date + 1.days]}}
  scope :tomorrow, -> {{conditions: ['start_time > ? AND start_time < ?', DateTime.now.utc.to_date + 1.days , DateTime.now.utc.to_date + 2.days]}}
  scope :later, -> { where("start_time > ?", Time.now.utc.to_date + 3.days) }

  validates_with AttachmentContentTypeValidator, attributes: :picture, content_type: ["image/jpg", "image/gif", "image/png"]

  def end_time
    start_time + duration
  end

end

