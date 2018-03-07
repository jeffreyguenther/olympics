athletes = Athlete.all.map{ |a| AthleteWithRecords.new(a)}
movements = Hash[Movement.all.map { |m| [m.name, m.id] }]
number_of_events = 100

naive = ImportStrategy::Naive.new(
  events: number_of_events,
  athletes: athletes,
  movements: movements
)
naive.import
puts naive.benchmark
puts "-" * 50
