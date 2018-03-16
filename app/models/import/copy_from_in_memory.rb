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

        stream_attempts(event, event_data.performances)
        stream_winners(event, event_data.winners)
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

    def stream_attempts(event, performances)
      performances.each { |p| p.results.each { |r| stream_attempt_data_via_copy(event, p.athlete, p.movement, r)}}
    end

    def stream_winners(event, winners)
      columns = ["event_id", "athlete_id", "created_at", "updated_at"]
      winners.each do |w|
        stream_data_via_copy("winners", columns, [event.id, w.id, Time.now.to_s, Time.now.to_s])
      end
    end

    def stream_attempt_data_via_copy(event, athlete, movement, attempt)
      columns = ["result", "attempt", "athlete_id", "movement_id", "created_at", "updated_at", "event_id", "success"]
      data = [attempt.score, attempt.attempt, athlete.id, @movement_ids[movement],
          Time.now.to_s, Time.now.to_s, event.id, attempt.success?
        ]
    end

    def stream_data_via_copy(table, columns, data)
      @pg_connection.copy_data("COPY #{table} (#{columns.join(",")}) FROM STDIN", @pg_encoding) do
        @pg_connection.put_copy_data(data)
      end
    end
end
