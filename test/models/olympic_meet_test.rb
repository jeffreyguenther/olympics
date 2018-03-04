require 'test_helper'

class OlympicMeetTest < ActiveSupport::TestCase
  test "returns olympic movements" do
    expected_movements = ["snatch", "clean & jerk"]

    assert_equal OlympicMeet.movements, expected_movements
  end
end
