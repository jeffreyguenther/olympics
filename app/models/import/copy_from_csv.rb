require "csv"

class Import::CopyFromCsv < Import::CopyFromInMemory
  include Benchmarkable

  ATTEMPTS_FILE = "attempts.csv"

  def import
    remove_csv

    @duration = Benchmark.ms do
      @events.times do
        event_data = Generator::Event.new(athletes: @athletes)

        event = build_event(event_data.type)

        stream_data_to_csv(event, event_data.performances)
      end
    end

    stream_data_via_copy
  end

  private
    def header
      "COPY FROM (csv)"
    end
  
    def remove_csv
      FileUtils.rm("#{Rails.root}/#{ATTEMPTS_FILE}", force: true)
    end

    def stream_data_to_csv(meet, performances)
      CSV.open("#{Rails.root}/#{ATTEMPTS_FILE}", "ab") do |csv|
        performances.each do |p|
          p.results.each do |r|
            csv << [r.score, r.attempt, p.athlete.id, @movement_ids[p.movement], "now()", "now()", meet.id, r.success?]
          end
        end
      end
    end

    def stream_data_via_copy
      @pg_connection.copy_data("COPY attempts (result,  attempt, athlete_id, movement_id, created_at, updated_at, event_id, success) FROM STDIN CSV") do
        File.open("#{Rails.root}/#{ATTEMPTS_FILE}") do |fd|
          while data = fd.read(100000)
            @pg_connection.put_copy_data(data)
          end
        end
      end
    end
end
