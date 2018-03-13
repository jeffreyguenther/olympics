module Benchmarkable
  extend ActiveSupport::Concern

  def benchmark
    runs = Event.run.count
    rows = Event.row.count
    olympics = Event.olympic.count
    powers = Event.power.count
    athletes  = @athletes.count
    expected_attempts = (runs * athletes) + (rows * athletes) + (6 * athletes * olympics) + (9 * athletes * powers)

    <<~BENCHMARK
      #{header}
      Generating #{@events} took #{@duration}ms
      Run Events: #{runs}
      Row Events: #{rows}
      Olympic Lifting Events: #{olympics}
      PowerLifting Events: #{powers}
      Attempts: #{Attempt.count}, expected #{expected_attempts}
      Speed: #{@duration / @events}ms per event
    BENCHMARK
  end
end
