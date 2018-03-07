class LiftPerformance
  attr_reader :results

  def initialize(starting_weight:, attempts: nil)
    @starting_weight = starting_weight
    @results = attempts || generate_random_attempts
  end

  private
    def generate_random_attempts
      current_weight = @starting_weight

      3.times.map do |attempt|
        attempt = LiftAttempt.new(attempt: attempt, weight: current_weight)
        current_weight = attempt.next_weight
        attempt
      end
    end
end
