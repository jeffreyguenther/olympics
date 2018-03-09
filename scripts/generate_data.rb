athletes = Athlete.all.map{ |a| AthleteWithRecords.new(a)}
movements = Hash[Movement.all.map { |m| [m.name, m.id] }]
number_of_events = 1000
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
  ),
  ImportStrategy::CopyFromCsv.new(
    events: number_of_events,
    athletes: athletes,
    movements: movements
  )
]

def clear_db
  Meet.delete_all
  Attempt.delete_all
end

benchmarks.each do |benchmark|
  clear_db

  benchmark.import

  puts benchmark.benchmark
  puts rule if benchmark != benchmarks.last
end
