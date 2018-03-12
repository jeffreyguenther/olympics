require 'test_helper'

class RowResultTest < ActiveSupport::TestCase
  test "generates random speed when none is provided" do
    meet = Generator::RowResult.new(distance: 500)
    possible_values = [:slow, :medium, :fast]

    assert_includes possible_values, meet.speed
  end

  test "generates slow 500m row" do
    meet = Generator::RowResult.new(distance: 500, speed: :slow)
    expected_range = (1.minute + 50.seconds..2.minutes + 30.seconds)

    assert_includes expected_range, meet.result
  end

  test "generates medium 500m row" do
    meet = Generator::RowResult.new(distance: 500, speed: :medium)
    expected_range = (1.minute + 35.seconds..1.minute + 49.seconds)

    assert_includes expected_range, meet.result
  end

  test "generates fast 500m row" do
    meet = Generator::RowResult.new(distance: 500, speed: :fast)
    expected_range = (1.minute + 15.seconds..1.minute + 34.seconds)

    assert_includes expected_range, meet.result
  end

  test "generates slow 1000m row" do
    meet = Generator::RowResult.new(distance: 1000, speed: :slow)
    expected_range = (3.minutes + 40.seconds..5.minutes)

    assert_includes expected_range, meet.result
  end

  test "generates medium 1000m row" do
    meet = Generator::RowResult.new(distance: 1000, speed: :medium)
    expected_range = (3.minute..3.minutes + 39.seconds)

    assert_includes expected_range, meet.result
  end

  test "generates fast 1000m row" do
    meet = Generator::RowResult.new(distance: 1000, speed: :fast)
    expected_range = (2.minute + 40.seconds..2.minutes + 59.seconds)

    assert_includes expected_range, meet.result
  end

  test "generates slow 5000m row" do
    meet = Generator::RowResult.new(distance: 5000, speed: :slow)
    expected_range = (20.minutes + 1.second..28.minutes)

    assert_includes expected_range, meet.result
  end

  test "generates medium 5000m row" do
    meet = Generator::RowResult.new(distance: 5000, speed: :medium)
    expected_range = (15.minutes + 1.second..20.minutes)

    assert_includes expected_range, meet.result
  end

  test "generates fast 5000m row" do
    meet = Generator::RowResult.new(distance: 5000, speed: :fast)
    expected_range = (13.minute + 30.seconds..15.minutes)

    assert_includes expected_range, meet.result
  end
end
