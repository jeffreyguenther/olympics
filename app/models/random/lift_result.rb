class Random::LiftResult
  attr_reader :attempt, :result

  def initialize(attempt:, result: nil)
    @attempt = attempt
    @result = result || generate_random_result
  end

  def success?
    case attempt
    when 0
      make_first_attempt
    when 1
      make_second_attempt
    when 2
      make_third_attempt
    else
      false
    end
  end

  private
    def generate_random_result
      @@prng ||= Random.new
      @@prng.rand(0..3)
    end

    def make_first_attempt
      (0..2).include?(@result)
    end

    def make_second_attempt
      (0..1).include?(@result)
    end

    def make_third_attempt
      0 == @result
    end
end
