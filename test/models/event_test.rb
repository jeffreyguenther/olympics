# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  kinds      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "distribution" do
    create(:event, kinds: "power")
    create(:event, kinds: "power")
    create(:event, kinds: "olympic")
    create(:event, kinds: "olympic")
    create(:event, kinds: "olympic")

    distribution = Event.distribution

    assert_equal 2, distribution["power"]
    assert_equal 3, distribution["olympic"]
  end
end
