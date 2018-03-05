class PowerliftingMeet
  def self.movements
    ["squat", "bench", "deadlift"]
  end

  def self.starting_snatch_weight
    generate_rounded_weight_between((100..185))
  end

  def self.starting_clean_and_jerk_weight
    generate_rounded_weight_between(135..185)
  end

  private
    def self.generate_weight_in(range)
      @@prng ||= Random.new
      weight = @@prng.rand(range)
    end

    def self.generate_rounded_weight_between(range)
      weight = generate_weight_in(range)
      round_to_nearest_five_pounds(weight)
    end

    def self.round_to_nearest_five_pounds(weight)
      (weight / 5.0).round * 5
    end
end
