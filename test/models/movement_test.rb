# == Schema Information
#
# Table name: movements
#
#  id                     :integer          not null, primary key
#  weighted_max_effort_id :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#

require 'test_helper'

class MovementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
