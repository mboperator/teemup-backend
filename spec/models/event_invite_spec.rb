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

require 'spec_helper'

describe EventInvite do
  pending "add some examples to (or delete) #{__FILE__}"
end
