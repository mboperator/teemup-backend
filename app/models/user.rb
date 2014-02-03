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
  has_many :admin_groups, through: :admin_memberships, source: :group
  has_many :admin_memberships, -> { merge(GroupMembership.admins)}, class_name: 'GroupMembership'
  has_many :groups, through: :group_memberships
  has_many :group_memberships

  has_many :event_invites
  has_many :events, through: :event_invites
  has_many :confirmed_event_invites, -> { merge(EventInvite.confirmed) }, class_name: 'EventInvite'
  has_many :confirmed_events, through: :confirmed_event_invites, source: :event

  has_many :confirmed_friendships, -> { merge(Friendship.confirmed) }, class_name: 'Friendship'
  has_many :confirmed_friends, through: :confirmed_friendships, source: :friend, class_name: 'User'
  has_many :unconfirmed_friendships, -> { merge(Friendships.unconfirmed) }, class_name: 'Friendship'
  has_many :unconfirmed_friends, through: :unconfirmed_friendships, source: :friend, class_name: 'User'

  has_many :confirmed_inverse_friendships, -> { merge(Friendship.confirmed) }, foreign_key: 'friend_id', class_name: 'Friendship'
  has_many :confirmed_inverse_friends, through: :confirmed_inverse_friendships, source: :user, class_name: 'User'
  has_many :unconfirmed_inverse_friendships, -> { merge(Friendships.unconfirmed) }, foreign_key: 'friend_id', class_name: 'Friendship'
  has_many :unconfirmed_inverse_friends, through: :unconfirmed_inverse_friendships, source: :user, class_name: 'User'


  validates :email, presence: true, uniqueness: true, format: /\A*.+@.+\z/
  validates :password, presence: true, length: { minimum: 6 }, if: :password

  before_save { self.email = email.downcase }
  after_save :create_access_token

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.new_remember_token
    SecureRandom.urlsafe_base64.to_s
  end

  def full_name
    [first_name, last_name].join(' ').presence || email
  end

  def friends
    confirmed_friends + confirmed_inverse_friends
  end

  private
  def create_access_token
    self.api_keys.create!
  end

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end

