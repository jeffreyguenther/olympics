class Generator::LiftAttempt
  WEIGHT_JUMP = 5
  attr_reader :attempt, :weight, :result

  def initialize(attempt:, weight:, result: nil)
    @attempt = attempt
    @weight = weight
    @result = result || generate_random_result
  end

  delegate :success?, to: :result
  alias_method :score, :weight

  def next_weight
    if success?
      weight + WEIGHT_JUMP
    else
      weight
    end
  end

  private
    def generate_random_result
      Generator::LiftResult.new(attempt: attempt)
    end
end
