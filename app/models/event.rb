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

  scope :today, -> {where('start_time > ? AND start_time < ?', DateTime.now.to_date , DateTime.now.to_date + 1.days)}
  scope :tomorrow, -> {where('start_time > ? AND start_time < ?', DateTime.now.to_date + 1.days , DateTime.now.to_date + 2.days)}
  scope :later, -> {where("start_time > ?", Time.now.to_date + 3.days)}
  scope :past, -> {where("start_time < ?", Time.now.to_date)}

  scope :daily_recurring, -> {where("daily_event", true)}
  scope :weekly_recurring, -> {where("weekly_event", true)}

  scope :ascending, -> {order('start_time ASC')}


  validates_with AttachmentContentTypeValidator, attributes: :picture, content_type: ["image/jpeg", "image/gif", "image/png"]

  def self.for(day)

    if daily_recurring.merge(past).count != 0
      daily_recurring.merge(past).each do |e|
        e.starting_time
      end

    elsif weekly_recurring.merge(past).count != 0
      weekly_recurring.merge(past).each do |e|
        e.starting_time
      end

    end

    if day == 'today'
      return self.today
    elsif day == 'tomorrow'
      return self.tomorrow
    else
      return self.later
    end

  end

  def end_time
    start_time + duration
  end


  def starting_time
    if daily_event

      if end_time > DateTime.now
        self.start_time
      else
        self.start_time = self.start_time + (self.start_time.to_date - DateTime.now.to_date).abs.days
        self.save
        self.start_time
      end

    elsif weekly_event

      while end_time < DateTime.now
        self.start_time = self.start_time + 7.days
      end
      self.save
      self.start_time

    else
      self.start_time
    end

  end


end

