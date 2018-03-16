class Generator::RunningEvent < Generator::DistanceEvent

  def movement_type
    "run"
  end

  def generate_performance(distance, athlete)
    movement = movement_for_distance(distance)

    result = Generator::RunResult.new(distance: distance)
    Generator::AthletePerformance.new(
      athlete: athlete,
      movement: movement,
      score: result.score,
      results: [result]
    )
  end
end
