class LiftPerformance
  attr_reader :results

  def initialize(starting_weight:)
    @starting_weight = starting_weight
  end

  def generate
    @results = []
    current_weight = @starting_weight

    3.times do |attempt|
      attempt = LiftAttempt.new(attempt: attempt, weight: current_weight)
      current_weight = attempt.next_weight
      @results.push(attempt)
    end
  end
end
