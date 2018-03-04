require 'test_helper'

class LiftResultTest < ActiveSupport::TestCase
  test "succeed when attempt is 0 and result is 0" do
    result = LiftResult.new(attempt: 0, result: 0)

    assert result.success?
  end

  test "succeed when attempt is 0 and result is 1" do
    result = LiftResult.new(attempt: 0, result: 1)

    assert result.success?
  end

  test "succeed when attempt is 0 and result is 2" do
    result = LiftResult.new(attempt: 0, result: 2)

    assert result.success?
  end

  test "fail when attempt is 0 and result is 3" do
    result = LiftResult.new(attempt: 0, result: 3)

    assert_not result.success?
  end

  test "succeed when attempt is 1 and result is 0" do
    result = LiftResult.new(attempt: 1, result: 0)

    assert result.success?
  end

  test "succeed when attempt is 1 and result is 1" do
    result = LiftResult.new(attempt: 1, result: 1)

    assert result.success?
  end

  test "fail when attempt is 1 and result is 2" do
    result = LiftResult.new(attempt: 1, result: 2)

    assert_not result.success?
  end

  test "fail when attempt is 1 and result is 3" do
    result = LiftResult.new(attempt: 1, result: 3)

    assert_not result.success?
  end

  test "succeed when attempt is 2 and result is 0" do
    result = LiftResult.new(attempt: 2, result: 0)

    assert result.success?
  end

  test "fail when attempt is 2 and result is 1" do
    result = LiftResult.new(attempt: 2, result: 1)

    assert_not result.success?
  end

  test "fail when attempt is 2 and result is 2" do
    result = LiftResult.new(attempt: 2, result: 2)

    assert_not result.success?
  end

  test "fail when attempt is 2 and result is 3" do
    result = LiftResult.new(attempt: 2, result: 3)

    assert_not result.success?
  end

  test "generate result between 0 and 3" do
    lift_result = LiftResult.new(attempt: 1)
    expected_range = (0..3)

    assert_includes expected_range, lift_result.result
  end
end
