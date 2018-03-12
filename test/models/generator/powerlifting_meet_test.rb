require 'test_helper'

class PowerliftingMeetTest < ActiveSupport::TestCase
  test "returns olympic movements" do
    expected_movements = ["squat", "bench", "deadlift"]

    assert_equal Generator::PowerliftingMeet.movements, expected_movements
  end

  test "generate starting squat weight" do
    expected_range = 135..205

    weight = Generator::PowerliftingMeet.opening_squat_weight

    assert_includes expected_range, weight
    assert_equal weight % 5, 0
  end

  test "generate starting bench weight" do
    expected_range = 100..225

    weight = Generator::PowerliftingMeet.opening_bench_weight

    assert_includes expected_range, weight
    assert_equal weight % 5, 0
  end

  test "generate starting deadlift weight" do
    expected_range = 185..315

    weight = Generator::PowerliftingMeet.opening_deadlift_weight

    assert_includes expected_range, weight
    assert_equal weight % 5, 0
  end

  test "generate random opening weight for squat" do
    expected_range = 135..205

    weight = Generator::PowerliftingMeet.opening_weight_for("squat")

    assert_includes expected_range, weight
    assert_equal weight % 5, 0
  end

  test "generate random opening weight for bench weight" do
    expected_range = 100..225

    weight = Generator::PowerliftingMeet.opening_weight_for("bench")

    assert_includes expected_range, weight
    assert_equal weight % 5, 0
  end

  test "generate random opening weight for deadlift weight" do
    expected_range = 185..315

    weight = Generator::PowerliftingMeet.opening_weight_for("deadlift")

    assert_includes expected_range, weight
    assert_equal weight % 5, 0
  end
end
