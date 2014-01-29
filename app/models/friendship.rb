class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"

  scope :confirmed, -> { where(is_confirmed: true) }
  scope :unconfirmed, -> { where(is_confirmed: false)}

  def make_confirm
    update_attributes(is_confirmed: true)
  end
end
