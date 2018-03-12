class Generator::LiftPerformance
  attr_reader :results

  def initialize(starting_weight:, attempts: nil)
    @starting_weight = starting_weight
    @results = attempts || generate_random_attempts
  end

  def best_weight
    results.select{ |r| r.success? }.map { |r| r.weight }.max || 0
  end

  private
    def generate_random_attempts
      current_weight = @starting_weight

      3.times.map do |attempt|
        attempt = Generator::LiftAttempt.new(attempt: attempt, weight: current_weight)
        current_weight = attempt.next_weight
        attempt
      end
    end
end
