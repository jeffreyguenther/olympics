class ImportStrategy::Naive
  def initialize(events: 1, athletes:, movements:)
    @events = events
    @duration  = 0
    @athletes = athletes
    @movement_ids = movements
  end

  def import
    # generate meet type
    @duration = Benchmark.ms do
      @events.times do
        @meet_results = WeightLiftingMeet.new(type: OlympicMeet, athletes: @athletes).results
        meet = build_meet("olympic")
        meet.attempts << build_records_for_athletes
        meet.save
      end
    end
  end

  def benchmark
    <<~BENCHMARK
      Naive Import
      Generating #{@events} took #{@duration}ms
      Meets: #{WeightedMaxEffort.count}
      Attempts: #{Attempt.count}
      Speed: #{@duration / @events}ms per event
    BENCHMARK
  end

  private
    def build_meet(type)
      WeightedMaxEffort.new(lifts: type)
    end

    def build_records_for_athletes
      @athletes.map { |athlete| build_records_for_athlete(athlete)}.flatten
    end

    def build_records_for_athlete(athlete)
      @meet_results[athlete].map do |movement, performance|
        build_records_for_performance(athlete, movement, performance)
      end
    end

    def build_records_for_performance(athlete, movement, performance)
      performance.results.map { |attempt| build_record_for_attempt(athlete, movement, attempt)  }
    end

    def build_record_for_attempt(athlete, movement, attempt)
      Attempt.new(
        attempt: attempt.attempt,
        weight: attempt.weight,
        success: attempt.success?,
        athlete_id: athlete.id,
        movement_id: @movement_ids[movement]
      )
    end
end
