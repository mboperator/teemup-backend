# == Schema Information
#
# Table name: event_invites
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  event_id     :integer          not null
#  is_admin     :boolean          default(FALSE)
#  is_confirmed :boolean          default(FALSE)
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
