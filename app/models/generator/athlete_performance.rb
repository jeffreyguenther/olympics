class Generator::AthletePerformance
  attr_reader :athlete, :movement, :results

  def initialize(athlete:, movement:, results:)
    @athlete = athlete
    @movement = movement
    @results = results
  end
end
