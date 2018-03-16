class Generator::WeightLiftingMeet
  attr_reader :results

  def initialize(type:, athletes:, performances: nil)
    @type = type
    @athletes = athletes
    @results = performances || generate_athlete_performances
  end

  def winners
    athlete_performances = results.group_by(&:athlete)

    athlete_totals = athlete_performances.map do |athlete, movement|
      combined_total = movement.map { |m| m.score }.reduce(:+)
      [athlete, combined_total]
    end

    athlete_totals = Hash[athlete_totals]
    top_score = athlete_totals.map { |a, weight| weight }.max

    athlete_totals.select { |_, weight| top_score == weight }
      .map{ |a, _| a }
  end

  private
    def movements
      @type.movements
    end

    def generate_athlete_performances
      athlete_performances = @athletes.map do |athlete|
        movements.map do |movement|
          result = Generator::LiftPerformance.new(starting_weight: athlete.opening_weight(@type, movement))
          best_weight = result.best_weight
          athlete.update_records_for(movement, best_weight)

          Generator::AthletePerformance.new(
            athlete: athlete,
            movement: movement,
            score: best_weight,
            results: result.results
          )
        end
      end

      athlete_performances.flatten
    end
end
