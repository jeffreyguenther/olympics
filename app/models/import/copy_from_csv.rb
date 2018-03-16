require "csv"

class Import::CopyFromCsv < Import::CopyFromInMemory
  include Benchmarkable

  ATTEMPTS_FILE = "attempts.csv"
  WINNERS_FILE = "winners.csv"
  WINNERS_COLUMNS = ["event_id", "athlete_id", "created_at", "updated_at"]
  ATTEMPTS_COLUMNS = [
    "result", "attempt", "athlete_id",
    "movement_id", "created_at",
    "updated_at", "event_id", "success"
  ]

  def import
    remove_csv

    @duration = Benchmark.ms do
      @events.times do
        event_data = Generator::Event.new(athletes: @athletes)

        event = build_event(event_data.type)

        stream_attempt_data_to_csv(event, event_data.performances)
        stream_winner_data_to_csv(event, event_data.winners)
      end
    end

    stream_data_via_copy(ATTEMPTS_FILE, "attempts", ATTEMPTS_COLUMNS)
    stream_data_via_copy(WINNERS_FILE, "winners", WINNERS_COLUMNS)
  end

  private
    def header
      "COPY FROM (csv)"
    end

    def remove_csv
      FileUtils.rm("#{Rails.root}/#{ATTEMPTS_FILE}", force: true)
      FileUtils.rm("#{Rails.root}/#{WINNERS_FILE}", force: true)
    end

    def stream_attempt_data_to_csv(event, performances)
      CSV.open("#{Rails.root}/#{ATTEMPTS_FILE}", "ab") do |csv|
        performances.each do |p|
          p.results.each do |r|
            csv << [r.score, r.attempt, p.athlete.id, @movement_ids[p.movement], "now()", "now()", event.id, r.success?]
          end
        end
      end
    end

    def stream_winner_data_to_csv(event, winners)
      CSV.open("#{Rails.root}/#{WINNERS_FILE}", "ab") do |csv|
        winners.each do |w|
          csv << [event.id, w.id, Time.now.to_s, Time.now.to_s]
        end
      end
    end

    def stream_data_via_copy(file, table, columns)
      @pg_connection.copy_data("COPY #{table} (#{columns.join(",")}) FROM STDIN CSV") do
        File.open("#{Rails.root}/#{file}") do |fd|
          while data = fd.read(100000)
            @pg_connection.put_copy_data(data)
          end
        end
      end
    end
end
