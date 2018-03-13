athletes = Athlete.all.map{ |a| Import::AthleteWithRecords.new(a)}
movements = Hash[Movement.all.map { |m| [m.name, m.id] }]
number_of_events = 10
rule = "-" * 50
benchmarks = [
  Import::Naive.new(
    events: number_of_events,
    athletes: athletes,
    movements: movements
  ),
  Import::InsertInto.new(
    events: number_of_events,
    athletes: athletes,
    movements: movements
  ),
  Import::CopyFromInMemory.new(
    events: number_of_events,
    athletes: athletes,
    movements: movements
  ),
  Import::CopyFromCsv.new(
    events: number_of_events,
    athletes: athletes,
    movements: movements
  )
]

def clear_db
  Event.delete_all
  Attempt.delete_all
end

benchmarks.each do |benchmark|
  clear_db

  benchmark.import

  puts benchmark.benchmark
  puts rule if benchmark != benchmarks.last
end
