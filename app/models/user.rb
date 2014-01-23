# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  first_name      :string(255)
#  last_name       :string(255)
#  phone_number    :string(255)
#  remember_token  :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#  location_id     :integer
#

class User < ActiveRecord::Base
  has_secure_password

  belongs_to :location
  has_many :api_keys

  has_many :confirmed_memberships, -> { merge(GroupMembership.confirmed) }, class_name: 'GroupMembership'
  has_many :confirmed_groups, through: :confirmed_memberships, source: :group
  has_many :groups, through: :group_memberships
  has_many :group_memberships

  has_many :event_invites
  has_many :events, through: :event_invites
  has_many :confirmed_event_invites, -> { merge(EventInvite.confirmed) }, class_name: 'EventInvite'
  has_many :confirmed_events, through: :confirmed_event_invites, source: :event

  validates :email, presence: true, uniqueness: true, format: /\A*.+@.+\z/
  validates :password, presence: true, length: { minimum: 6 }, if: :password

  before_save { self.email = email.downcase }
  after_save :create_access_token

  private
  def create_access_token
    self.api_keys.create!
  end

end
