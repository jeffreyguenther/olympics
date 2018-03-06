class WeightLiftingMeet
  attr_reader :results

  def initialize(type:, athletes:)
    @type = type
    @athletes = athletes
  end

  def generate
    @results = {}

    @athletes.each do |athlete|
      movement_results = {}
      movements.each do |movement|
        result = LiftPerformance.new(starting_weight: athlete.opening_weight(movement, @type))
        result.generate

        movement_results[movement] = result
      end

      @results[athlete] = movement_results
    end
  end

  private
    def movements
      @type.movements
    end
end
