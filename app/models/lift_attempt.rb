class LiftAttempt
  WEIGHT_JUMP = 5
  attr_reader :attempt, :weight, :result

  def initialize(attempt:, weight:, result: nil)
    @attempt = attempt
    @weight = weight
    @result = result || generate_random_result
  end

  delegate :success?, to: :result

  def next_weight
    if success?
      weight + WEIGHT_JUMP
    else
      weight
    end
  end

  def store
    Attempt.new(weight: @weight, success: success?)
  end

  private
    def generate_random_result
      LiftResult.new(attempt: attempt)
    end
end
