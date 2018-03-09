require 'test_helper'

class LiftAttemptTest < ActiveSupport::TestCase
  test "lift is successful" do
    attempt_num = 0
    result = Random::LiftResult.new(attempt: attempt_num, result: 0)
    attempt = Random::LiftAttempt.new(attempt: attempt_num, weight: 100, result: result)

    assert attempt.success?
  end

  test "lift is not successful" do
    attempt_num = 0
    result = Random::LiftResult.new(attempt: attempt_num, result: 3)
    attempt = Random::LiftAttempt.new(attempt: attempt_num, weight: 100, result: result)

    assert_not attempt.success?
  end

  test "#next_weight is increment 5lbs on success" do
    attempt_num = 0
    attempted_weight = 100
    expected_weight = 105
    result = Random::LiftResult.new(attempt: attempt_num, result: 0)
    attempt = Random::LiftAttempt.new(attempt: attempt_num, weight: attempted_weight, result: result)

    assert_equal attempt.next_weight, expected_weight
  end

  test "#next_weight is unchanged on failure" do
    attempt_num = 0
    attempted_weight = 100
    result = Random::LiftResult.new(attempt: attempt_num, result: 3)
    attempt = Random::LiftAttempt.new(attempt: attempt_num, weight: attempted_weight, result: result)

    assert_equal attempt.next_weight, attempted_weight
  end

  test "result of attempt is random" do
    attempt_num = 0
    attempted_weight = 100
    attempt = Random::LiftAttempt.new(attempt: attempt_num, weight: attempted_weight)

    expected_range = (0..3)

    assert_includes expected_range, attempt.result.result
  end
end
