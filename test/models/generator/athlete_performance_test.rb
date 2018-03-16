require 'test_helper'

class AthletePerformanceTest < ActiveSupport::TestCase
  test "#score" do
    score = 10
    performance = Generator::AthletePerformance.new(athlete: nil, movement: nil, score: score, results: nil)

    assert_equal score, performance.score
  end
end
