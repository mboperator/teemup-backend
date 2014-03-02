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

require 'spec_helper'

describe Friendship do
  pending "add some examples to (or delete) #{__FILE__}"
end
