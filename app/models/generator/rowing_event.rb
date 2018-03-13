class Generator::RowingEvent < Generator::DistanceEvent

  def movement
    "row"
  end

  def generate_performance(distance, athlete)
    result = Generator::RowResult.new(distance: distance)
    Generator::AthletePerformance.new(athlete: athlete, movement: movement, results: [result])
  end
end
