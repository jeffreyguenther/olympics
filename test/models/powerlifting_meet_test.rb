require 'test_helper'

class PowerliftingMeetTest < ActiveSupport::TestCase
  test "returns olympic movements" do
    expected_movements = ["squat", "bench", "deadlift"]

    assert_equal PowerliftingMeet.movements, expected_movements
  end

  test "generate starting squat" do
    expected_range = 135..205

    weight = PowerliftingMeet.starting_squat_weight

    assert_includes expected_range, weight
    assert_equal weight % 5, 0
  end

  test "generate starting bench weight" do
    expected_range = 100..225

    weight = PowerliftingMeet.starting_bench_weight

    assert_includes expected_range, weight
    assert_equal weight % 5, 0
  end

  test "generate starting deadlift weight" do
    expected_range = 185..315

    weight = PowerliftingMeet.starting_deadlift_weight

    assert_includes expected_range, weight
    assert_equal weight % 5, 0
  end
end
