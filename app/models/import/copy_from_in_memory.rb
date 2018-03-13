class Import::CopyFromInMemory
  include Benchmarkable

  def initialize(events: 1, athletes:, movements:)
    @events = events
    @duration  = 0
    @athletes = athletes
    @movement_ids = movements
    @pg_connection = Attempt.connection.raw_connection
    @pg_encoding = PG::TextEncoder::CopyRow.new
  end

  def import
    @duration = Benchmark.ms do
      @events.times do
        event_data = Generator::Event.new(athletes: @athletes)

        event = build_event(event_data.type)

        stream_athletes(event, event_data.performances)
      end
    end
  end

  private
    def header
      "COPY FROM (in memory)"
    end

    def build_event(type)
      Event.create(kinds: type)
    end

    def stream_athletes(event, performances)
      performances.each { |p| p.results.each { |r| stream_data_via_copy(event, p.athlete, p.movement, r)}}
    end

    def stream_data_via_copy(event, athlete, movement, attempt)
      @pg_connection.copy_data("COPY attempts (result, attempt, athlete_id, movement_id, created_at, updated_at, event_id, success) FROM STDIN", @pg_encoding) do
        @pg_connection.put_copy_data([
          attempt.score, attempt.attempt, athlete.id, @movement_ids[movement],
          Time.now.to_s, Time.now.to_s, event.id, attempt.success?
        ])
      end
    end
end
