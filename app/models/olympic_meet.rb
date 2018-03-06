class OlympicMeet
  include Openable

  def self.movements
    ["snatch", "clean & jerk"]
  end

  def self.starting_snatch_weight
    generate_rounded_weight_between(100..185)
  end

  def self.starting_clean_and_jerk_weight
    generate_rounded_weight_between(135..185)
  end

  def self.random_opening_weight(movement)
    if movement == "snatch"
      starting_snatch_weight
    elsif movement == "clean & jerk"
      starting_clean_and_jerk_weight
    end
  end
end
