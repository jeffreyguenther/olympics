class Generator::RunningEvent < Generator::DistanceEvent

  def movement
    "run"
  end

  def generate_performance(distance, athlete)
    result = Generator::RunResult.new(distance: distance)
    Generator::AthletePerformance.new(athlete: athlete, movement: movement, results: [result])
  end
end
