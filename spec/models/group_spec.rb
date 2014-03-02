# == Schema Information
#
# Table name: groups
#
#  id            :integer          not null, primary key
#  name          :text             not null
#  description   :text
#  created_by_id :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#  is_public     :boolean          default(FALSE)
#

require 'spec_helper'

describe Group do
  pending "add some examples to (or delete) #{__FILE__}"
end
