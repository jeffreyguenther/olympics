class PowerliftingMeet
  def self.movements
    ["squat", "bench", "deadlift"]
  end

  def self.starting_squat_weight
    generate_rounded_weight_between(135..205)
  end

  def self.starting_bench_weight
    generate_rounded_weight_between(100..225)
  end

  def self.starting_deadlift_weight
    generate_rounded_weight_between(185..315)
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
