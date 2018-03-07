class ImportStrategy::CopyFromInMemory

  def initialize(events: 1, athletes:, movements:)
    @events = events
    @duration  = 0
    @athletes = athletes
    @movement_ids = movements
    @pg_connection = Attempt.connection.raw_connection
    @pg_encoding = PG::TextEncoder::CopyRow.new
  end

  def import
    # generate meet type
    @duration = Benchmark.ms do
      @events.times do
        @meet_results = WeightLiftingMeet.new(type: OlympicMeet, athletes: @athletes).results
        meet = build_meet("olympic")

        stream_athletes(meet)
      end
    end
  end

  def benchmark
    <<~BENCHMARK
      COPY FROM (in memory)
      Generating #{@events} took #{@duration}ms
      Meets: #{WeightedMaxEffort.count}
      Attempts: #{Attempt.count}
      Speed: #{@duration / @events}ms per event
    BENCHMARK
  end

  private
    def build_meet(type)
      WeightedMaxEffort.create(lifts: type)
    end

    def stream_athletes(meet)
      @athletes.each { |athlete| stream_athlete_results(meet, athlete)}
    end

    def stream_athlete_results(meet, athlete)
      @meet_results[athlete].map do |movement, performance|
        performance.results.each do |attempt|
          stream_data_via_copy(meet, athlete, movement, attempt)
        end
      end
    end

    def stream_data_via_copy(meet, athlete, movement, attempt)
      @pg_connection.copy_data("COPY attempts (weight, attempt, athlete_id, movement_id, created_at, updated_at, weighted_max_effort_id, success) FROM STDIN", @pg_encoding) do
        @pg_connection.put_copy_data([
          attempt.weight, attempt.attempt, athlete.id, @movement_ids[movement],
          Time.now.to_s, Time.now.to_s, meet.id, attempt.success?
        ])
      end
    end
end
