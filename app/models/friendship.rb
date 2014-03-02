# == Schema Information
#
# Table name: friendships
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  friend_id    :integer          not null
#  is_confirmed :boolean          default(FALSE)
#  created_at   :datetime
#  updated_at   :datetime
#

class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"

  scope :confirmed, -> { where(is_confirmed: true) }
  scope :unconfirmed, -> { where(is_confirmed: false)}

  def make_confirm
    update_attributes(is_confirmed: true)
  end
end

