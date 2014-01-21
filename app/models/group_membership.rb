# == Schema Information
#
# Table name: group_memberships
#
#  id           :integer          not null, primary key
#  group_id     :integer          not null
#  user_id      :integer          not null
#  is_admin     :boolean          default(FALSE)
#  is_confirmed :boolean          default(FALSE)
#  created_at   :datetime
#  updated_at   :datetime
#

class GroupMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates :user, presence: true
  validates :group, presence: true

  scope :confirmed, -> { where(is_confirmed: true) }

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
