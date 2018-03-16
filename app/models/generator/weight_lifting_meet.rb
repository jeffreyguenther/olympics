class Generator::WeightLiftingMeet
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
      athlete_performances = @athletes.map do |athlete|
        movements.map do |movement|
          result = Generator::LiftPerformance.new(starting_weight: athlete.opening_weight(@type, movement))
          athlete.update_records_for(movement, result.best_weight)

          Generator::AthletePerformance.new(athlete: athlete, movement: movement, results: result.results)
        end
      end

      athlete_performances.flatten
    end
end
