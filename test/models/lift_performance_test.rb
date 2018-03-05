require 'test_helper'

class LiftPerformanceTest < ActiveSupport::TestCase
  test "#results after three attempts" do
    performance = LiftPerformance.new(starting_weight: 100)
    performance.generate

    assert performance.results.count, 3

    first, second, _ = performance.results
    if first.success?
      assert second.weight > first.weight
    else
      assert_equal second.weight, first.weight
    end
  end
end
