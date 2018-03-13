class Generator::RowingEvent < Generator::DistanceEvent

  def movement_for_distance(distance)
    "#{distance}m row"
  end

  def generate_performance(distance, athlete)
    movement = movement_for_distance(distance)

    result = Generator::RowResult.new(distance: distance)
    Generator::AthletePerformance.new(athlete: athlete, movement: movement, results: [result])
  end
end
