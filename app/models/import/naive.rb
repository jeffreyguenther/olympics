class Import::Naive
  include Benchmarkable
  
  def initialize(events: 1, athletes:, movements:)
    @events = events
    @duration  = 0
    @athletes = athletes
    @movement_ids = movements
  end

  def import
    @duration = Benchmark.ms do
      @events.times do
        event_data = Generator::Event.new(athletes: @athletes)

        event = build_event(event_data.type)
        event.attempts << build_records_for_performances(event_data.performances)
        event.save
      end
    end
  end

  private
    def header
      "Naive Import"
    end

    def build_event(type)
      Event.new(kinds: type)
    end

    def build_records_for_performances(performances)
      performances.map { |p| p.results.map { |r| build_record_for_result(p.athlete, p.movement, r)}}
        .flatten
    end

    def build_record_for_result(athlete, movement, result)
      Attempt.new(
        attempt: result.attempt,
        result: result.score,
        success: result.success?,
        athlete_id: athlete.id,
        movement_id: @movement_ids[movement]
      )
    end
end
