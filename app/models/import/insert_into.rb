class Import::InsertInto < Import::Naive

  def import
    # generate meet type
    @duration = Benchmark.ms do
      meets = @events.times.map do
        @meet_results = Random::WeightLiftingMeet.new(type: Random::OlympicMeet, athletes: @athletes).results
        meet = build_meet("olympic")
        meet.attempts << build_records_for_athletes
        meet
      end

      Event.import(meets, recursive: true)
    end
  end

  def benchmark
    <<~BENCHMARK
      INSERT INTO
      Generating #{@events} took #{@duration}ms
      Events: #{Event.count}
      Attempts: #{Attempt.count}
      Speed: #{@duration / @events}ms per event
    BENCHMARK
  end
end
