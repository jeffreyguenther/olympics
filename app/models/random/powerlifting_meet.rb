class Random::PowerliftingMeet
  include Openable

  def self.movements
    ["squat", "bench", "deadlift"]
  end

  def self.opening_squat_weight
    generate_rounded_weight_between(135..205)
  end

  def self.opening_bench_weight
    generate_rounded_weight_between(100..225)
  end

  def self.opening_deadlift_weight
    generate_rounded_weight_between(185..315)
  end
end
