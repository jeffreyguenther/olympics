require 'test_helper'

class OlympicMeetTest < ActiveSupport::TestCase
  test "returns olympic movements" do
    expected_movements = ["snatch", "clean and jerk"]

    assert_equal OlympicMeet.movements, expected_movements
  end

  test "generate starting snatch weight" do
    expected_range = (100..185)

    weight = OlympicMeet.opening_snatch_weight

    assert_includes expected_range, weight
    assert_equal weight % 5, 0
  end

  test "generate starting clean and jerk weight" do
    expected_range = (135..185)

    weight = OlympicMeet.opening_clean_and_jerk_weight

    assert_includes expected_range, weight
    assert_equal weight % 5, 0
  end

  test "generate random opening weight for snatch" do
    expected_range = (100..185)

    weight = OlympicMeet.opening_weight_for("snatch")

    assert_includes expected_range, weight
    assert_equal weight % 5, 0
  end

  test "generate random opening weight for clean and jerk" do
    expected_range = (135..185)

    weight = OlympicMeet.opening_weight_for("clean and jerk")

    assert_includes expected_range, weight
    assert_equal weight % 5, 0
  end
end
