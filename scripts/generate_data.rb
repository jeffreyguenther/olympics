athletes = Athlete.all.map{ |a| AthleteWithRecords.new(a)}
movements = Hash[Movement.all.map { |m| [m.name, m.id] }]
number_of_events = 100
rule = "-" * 50
benchmarks = [
  ImportStrategy::Naive.new(
    events: number_of_events,
    athletes: athletes,
    movements: movements
  ),
  ImportStrategy::InsertInto.new(
    events: number_of_events,
    athletes: athletes,
    movements: movements
  ),
  ImportStrategy::CopyFromInMemory.new(
    events: number_of_events,
    athletes: athletes,
    movements: movements
  )
]

benchmarks.each do |benchmark|
  benchmark.import
  puts benchmark.benchmark
  puts rule if benchmark != benchmarks.last
end
