class AthleteWithRecords

  def initialize(athlete, records = {})
    @athlete = athlete
    @records = records
  end

  delegate :id, to: :@athlete

  def opening_weight(meet_type, movement)
    current_max = @records[movement]
    if current_max.blank?
      meet_type.opening_weight_for(movement)
    else
       current_max - 10
    end
  end

  def update_records_for(movement, performance)
    performance_max = performance.best_weight

    current_max = @records[movement]
    if current_max.blank? || current_max < performance_max
      @records[movement] = performance_max
    end
  end
end
