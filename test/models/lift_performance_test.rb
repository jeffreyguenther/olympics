require 'test_helper'

class LiftPerformanceTest < ActiveSupport::TestCase
  test "#results after three attempts" do
    performance = Random::LiftPerformance.new(starting_weight: 100)

    assert performance.results.count, 3

    first, second, _ = performance.results
    if first.success?
      assert second.weight > first.weight
    else
      assert_equal second.weight, first.weight
    end
  end

  test "#best_weight returns max if a lift is successful" do
    attempts = [
      Random::LiftAttempt.new(attempt: 0, weight: 100, result: Random::LiftResult.new(attempt: 0, result: 0)),
      Random::LiftAttempt.new(attempt: 1, weight: 105, result: Random::LiftResult.new(attempt: 1, result: 0)),
      Random::LiftAttempt.new(attempt: 2, weight: 110, result: Random::LiftResult.new(attempt: 2, result: 1)),
    ]
    performance = Random::LiftPerformance.new(starting_weight: nil, attempts: attempts)

    assert_equal 105, performance.best_weight
  end

  test "#best_weight returns null if no lift is successful" do
    attempts = [
      Random::LiftAttempt.new(attempt: 0, weight: 100, result: Random::LiftResult.new(attempt: 0, result: 3)),
      Random::LiftAttempt.new(attempt: 1, weight: 100, result: Random::LiftResult.new(attempt: 1, result: 3)),
      Random::LiftAttempt.new(attempt: 2, weight: 100, result: Random::LiftResult.new(attempt: 2, result: 3)),
    ]
    performance = Random::LiftPerformance.new(starting_weight: nil, attempts: attempts)

    assert_equal 0, performance.best_weight
  end
end
