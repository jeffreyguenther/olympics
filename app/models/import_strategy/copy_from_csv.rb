require "csv"

class ImportStrategy::CopyFromCsv < ImportStrategy::CopyFromInMemory
  ATTEMPTS_FILE = "attempts.csv"

  def import
    remove_csv

    @duration = Benchmark.ms do
      @events.times do
        @meet_results = WeightLiftingMeet.new(type: OlympicMeet, athletes: @athletes).results
        meet = build_meet("olympic")

        stream_data_to_csv(meet)
      end
    end

    stream_data_via_copy
  end

  def benchmark
    <<~BENCHMARK
      COPY FROM (csv)
      Generating #{@events} took #{@duration}ms
      Events: #{Event.count}
      Attempts: #{Attempt.count}
      Speed: #{@duration / @events}ms per event
    BENCHMARK
  end

  private
    def remove_csv
      FileUtils.rm("#{Rails.root}/#{ATTEMPTS_FILE}", force: true)
    end

    def stream_athletes(meet, csv)
      @athletes.each { |athlete| stream_athlete_results(meet, athlete, csv)}
    end

    def stream_athlete_results(meet, athlete,  csv)
      @meet_results[athlete].each_pair do |movement, performance|
        performance.results.each do |attempt|
          csv << [attempt.weight, attempt.attempt, athlete.id, @movement_ids[movement], "now()", "now()", meet.id, attempt.success?]
        end
      end
    end

    def stream_data_to_csv(meet)
      CSV.open("#{Rails.root}/#{ATTEMPTS_FILE}", "ab") do |csv|
        stream_athletes(meet, csv)
      end
    end

    def stream_data_via_copy
      @pg_connection.copy_data("COPY attempts (weight,  attempt, athlete_id, movement_id, created_at, updated_at, weighted_max_effort_id, success) FROM STDIN CSV") do
        File.open("#{Rails.root}/#{ATTEMPTS_FILE}") do |fd|
          while data = fd.read(100000)
            @pg_connection.put_copy_data(data)
          end
        end
      end
    end
end
