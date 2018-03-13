class Import::InsertInto < Import::Naive
  include Benchmarkable

  def import
    @duration = Benchmark.ms do
      events = @events.times.map do
        event_data = Generator::Event.new(athletes: @athletes)

        event = build_event(event_data.type)
        event.attempts << build_records_for_performances(event_data.performances)

        event
      end

      Event.import(events, recursive: true)
    end
  end

  private
    def header
      "INSERT INTO"
    end
end
