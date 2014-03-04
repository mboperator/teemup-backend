# == Schema Information
#
# Table name: event_invites
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  event_id     :integer
#  is_admin     :boolean
#  is_confirmed :boolean
#  created_at   :datetime
#  updated_at   :datetime
#

class EventInvite < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  validates :event, presence: true
  validates :user, presence: true
  scope :confirmed, -> { where(is_confirmed: true) }
  scope :admins, -> { where(is_admin: true ) }

  def make_confirm
    update_attributes(is_confirmed: true)
  end

  def make_admin
    update_attributes(is_admin: true)
  end

  def revoke_admin
    update_attributes(is_admin: false)
  end
end

