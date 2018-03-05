# == Schema Information
#
# Table name: attempts
#
#  id                     :integer          not null, primary key
#  weight                 :integer
#  athlete_id             :integer
#  movement_id            :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  weighted_max_effort_id :integer
#  success                :boolean          default(FALSE)
#

require 'test_helper'

class AttemptTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
