athletes = Athlete.all.map{ |a| Import::AthleteWithRecords.new(a)}
movements = Hash[Movement.all.map { |m| [m.name, m.id] }]
number_of_events = 100_000

import = Import::CopyFromCsv.new(
  events: number_of_events,
  athletes: athletes,
  movements: movements
)
import.import
puts import.benchmark
