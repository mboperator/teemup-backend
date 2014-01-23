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

require 'spec_helper'

describe EventInvite do
  pending "add some examples to (or delete) #{__FILE__}"
end
