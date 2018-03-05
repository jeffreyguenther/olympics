require 'test_helper'

class OlympicMeetTest < ActiveSupport::TestCase
  test "returns olympic movements" do
    expected_movements = ["snatch", "clean & jerk"]

    assert_equal OlympicMeet.movements, expected_movements
  end

  test "generate starting snatch weight" do
    expected_range = (100..185)

    weight = OlympicMeet.starting_snatch_weight

    assert_includes expected_range, weight
    assert_equal weight % 5, 0
  end

  test "generate starting clean and jerk weight" do
    expected_range = (135..185)

    weight = OlympicMeet.starting_clean_and_jerk_weight

    assert_includes expected_range, weight
    assert_equal weight % 5, 0
  end
end
