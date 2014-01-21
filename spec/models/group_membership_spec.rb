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

require 'spec_helper'

describe GroupMembership do
  pending "add some examples to (or delete) #{__FILE__}"
end
