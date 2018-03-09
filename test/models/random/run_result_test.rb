require 'test_helper'

class RunResultTest < ActiveSupport::TestCase
  test "generates random speed when none is provided" do
    meet = Random::RunResult.new(distance: 500)
    possible_values = [:slow, :medium, :fast] 

    assert_includes possible_values, meet.speed
  end

  test "generates slow 500m run" do
    meet = Random::RunResult.new(distance: 500, speed: :slow)
    expected_range = (1.minute + 16.seconds..2.minutes)

    assert_includes expected_range, meet.result
  end

  test "generates medium 500m run" do
    meet = Random::RunResult.new(distance: 500, speed: :medium)
    expected_range = (56.seconds..1.minute + 15.seconds)

    assert_includes expected_range, meet.result
  end

  test "generates fast 500m run" do
    meet = Random::RunResult.new(distance: 500, speed: :fast)
    expected_range = (40.seconds..55.seconds)

    assert_includes expected_range, meet.result
  end

  test "generates slow 1000m run" do
    meet = Random::RunResult.new(distance: 1000, speed: :slow)
    expected_range = (3.minutes + 31.seconds..5.minutes)

    assert_includes expected_range, meet.result
  end

  test "generates medium 1000m run" do
    meet = Random::RunResult.new(distance: 1000, speed: :medium)
    expected_range = (2.minute + 51.seconds..3.minutes + 30.seconds)

    assert_includes expected_range, meet.result
  end

  test "generates fast 1000m run" do
    meet = Random::RunResult.new(distance: 1000, speed: :fast)
    expected_range = (2.minute + 20.seconds..2.minutes + 50.seconds)

    assert_includes expected_range, meet.result
  end

  test "generates slow 5000m run" do
    meet = Random::RunResult.new(distance: 5000, speed: :slow)
    expected_range = (20.minutes + 1.seconds..28.minutes)

    assert_includes expected_range, meet.result
  end

  test "generates medium 5000m run" do
    meet = Random::RunResult.new(distance: 5000, speed: :medium)
    expected_range = (15.minute + 1.seconds..20.minutes)

    assert_includes expected_range, meet.result
  end

  test "generates fast 5000m run" do
    meet = Random::RunResult.new(distance: 5000, speed: :fast)
    expected_range = (13.minute + 30.seconds..15.minutes)

    assert_includes expected_range, meet.result
  end
end
