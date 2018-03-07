class WeightLiftingMeet
  attr_reader :results

  def initialize(type:, athletes:, performances: nil)
    @type = type
    @athletes = athletes
    @results = performances || generate_athlete_performances
  end

  private
    def movements
      @type.movements
    end

    def generate_athlete_performances
      results = {}

      @athletes.each do |athlete|
        movement_results = {}
        movements.each do |movement|
          result = LiftPerformance.new(starting_weight: athlete.opening_weight(@type, movement))
          movement_results[movement] = result
        end

        results[athlete] = movement_results
      end

      results
    end
end
