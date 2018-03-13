class Generator::LiftResult
  include Randomable

  attr_reader :attempt, :result

  def initialize(attempt:, result: nil)
    @attempt = attempt
    @result = result || generate_random_result
  end

  def success?
    case attempt
    when 0
      test_first_attempt
    when 1
      test_second_attempt
    when 2
      test_third_attempt
    else
      false
    end
  end

  private
    def generate_random_result
      random_between(0..3)
    end

    def test_first_attempt
      (0..2).include?(@result)
    end

    def test_second_attempt
      (0..1).include?(@result)
    end

    def test_third_attempt
      0 == @result
    end
end
