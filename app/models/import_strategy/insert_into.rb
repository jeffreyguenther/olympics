class ImportStrategy::InsertInto < ImportStrategy::Naive

  def import
    # generate meet type
    @duration = Benchmark.ms do
      meets = @events.times.map do
        @meet_results = WeightLiftingMeet.new(type: OlympicMeet, athletes: @athletes).results
        meet = build_meet("olympic")
        meet.attempts << build_records_for_athletes
        meet
      end

      WeightedMaxEffort.import(meets, recursive: true)
    end
  end

  def benchmark
    <<~BENCHMARK
      INSERT INTO
      Generating #{@events} took #{@duration}ms
      Meets: #{WeightedMaxEffort.count}
      Attempts: #{Attempt.count}
      Speed: #{@duration / @events}ms per event
    BENCHMARK
  end
end
