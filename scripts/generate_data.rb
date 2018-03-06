require 'benchmark'
require "csv"

class AthleteWithRecords
  attr_accessor :records
  attr_reader :athlete

  def initialize(athlete)
    @athlete = athlete
    @records = {}
  end

  def opening_weight(movement, meet_type)
    @records[movement] || meet_type.random_opening_weight(movement)
  end
end

def create_weight_lifting_meet_records(athletes, results)
  # create weighted_max_effort
  meet = WeightedMaxEffort.new(lifts: "olympic")
  athletes.each do |athlete|
    movement_results = results[athlete]
    movement_results.each_pair do |name, movement|
      attempt_records = movement.store

      meet.attempts << attempt_records.each do |a|
        a.weighted_max_effort = meet
        a.athlete = athlete.athlete
        a.movement = @movements[name]
      end

    end
  end
  meet
end

def create_weight_lifting_meet_records_as_csv(athletes, results)
  meet = WeightedMaxEffort.create(lifts: "olympic")
  athletes.each do |athlete|
    movement_results = results[athlete]
    movement_results.each_pair do |name, movement|
      movement.results.each do |attempt|
        @pgconn.copy_data("COPY attempts (weight, athlete_id, movement_id, created_at, updated_at, weighted_max_effort_id, success) FROM STDIN", @enco) do
          @pgconn.put_copy_data([attempt.weight, athlete.athlete.id, @movements[name].id, Time.now.to_s, Time.now.to_s, meet.id, attempt.success?])
        end
      end
  end
  end

  meet
end

# Load all the items we need into memory
athletes = Athlete.all.map{ |a| AthleteWithRecords.new(a)}
@movements = {
  "run" => Movement.find_by(name: "run"),
  "row" => Movement.find_by(name: "row"),
  "squat" => Movement.find_by(name: "squat"),
  "bench" => Movement.find_by(name: "bench"),
  "deadlift" => Movement.find_by(name: "deadlift"),
  "clean & jerk" => Movement.find_by(name: "clean & jerk"),
  "snatch" => Movement.find_by(name: "snatch")
}

# Generate random match type
# Generate match
# FileUtils.rm "#{Rails.root}/import.csv"
time_to_run = Benchmark.ms do
  @pgconn = Attempt.connection.raw_connection
  @enco = PG::TextEncoder::CopyRow.new

  meets = 1_000.times.map do
    meet = WeightLiftingMeet.new(type: OlympicMeet, athletes: athletes)
    meet.generate

    create_weight_lifting_meet_records_as_csv(athletes, meet.results)
  end
  # WeightedMaxEffort.import(meets, recursive: true)

  # pgconn.copy_data("COPY attempts (weight, athlete_id, movement_id, created_at, updated_at, weighted_max_effort_id, success) FROM STDIN CSV") do
  #   File.open("#{Rails.root}/import.csv") do |fd|
  #     while data=fd.read(100000)
  #       pgconn.put_copy_data data
  #     end
  #   end
  # end
end
puts "Time: #{time_to_run}"
puts WeightedMaxEffort.count

# 4Ghz Core i7 - Late 2015, High Sierra
# 32 GB 1867 MHz DDR3
#######################################
# Using in memory store
# 100 naive = 2427.9829999977665
# 100 import 823.4510000002047
# 10_000 Time: 86233.60400000092

# Using export and then import via COPY FROM
# Export - 1 Time: 13.020999998843763
# Export - 100 Time: 269.8019999988901
# Export - 1_000 Time: 2353.592999999819
# Export - 100_000 264208.20199999795

# Export to CSV and then Import via COPY FROM
# Combined - 100 Time:             239.45499999899766
# Combined - 1_000 Time:          2143.2869999989634
# In Memory - 1_000 Time:         7224.332999998296
# Combined - 10_000 Time:        22473.47200000513
# Combined - 100_000 Time:      241830.86600000388
