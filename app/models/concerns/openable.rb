module Openable
  extend ActiveSupport::Concern

  class_methods do
    def generate_weight_between(range)
      @@prng ||= Random.new
      @@prng.rand(range)
    end

    def generate_rounded_weight_between(range)
      weight = generate_weight_between(range)
      round_to_nearest_five_pounds(weight)
    end

    def round_to_nearest_five_pounds(weight)
      (weight / 5.0).round * 5
    end

    def opening_weight_for(movement)
      method = "opening_#{movement.parameterize(separator: "_")}_weight".to_sym
      send(method)
    end
  end
end
