require 'test_helper'

class DistanceResultTest < ActiveSupport::TestCase
  test "#attempt" do
    event = Generator::DistanceResult.new(distance: 1, speed: 0, result: 10)

    assert_equal 0, event.attempt
  end

  test "#success?" do
    event = Generator::DistanceResult.new(distance: 1, speed: 0, result: 10)

    assert event.success?
  end
end
