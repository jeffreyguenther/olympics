module Roundable
  extend ActiveSupport::Concern

  class_methods do
    def generate_weight_in(range)
      @@prng ||= Random.new
      weight = @@prng.rand(range)
    end

    def generate_rounded_weight_between(range)
      weight = generate_weight_in(range)
      round_to_nearest_five_pounds(weight)
    end

    def round_to_nearest_five_pounds(weight)
      (weight / 5.0).round * 5
    end
  end
end
