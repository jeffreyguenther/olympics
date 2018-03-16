class Generator::AthletePerformance
  attr_reader :athlete, :movement, :results, :score

  def initialize(athlete:, movement:, score:, results:)
    @athlete = athlete
    @movement = movement
    @results = results
    @score = score
  end
end
