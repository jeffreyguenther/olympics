class Generator::Event
  include Randomable

  attr_reader :type, :performances

  def initialize(athletes:, type: nil)
    @athletes = athletes
    @type = type || generate_event_type
    @event = generate_event(@type)
    @performances = @event.results
  end

  def winners
    @event.winners
  end

  private
    def generate_event(type)
      case type
      when 0
        generate_olympic_event
      when 1
        generate_powerlifting_event
      when 2
        generate_run_event
      when 3
        generate_row_event
      end
    end

    def generate_run_event
      Generator::RunningEvent.new(athletes: @athletes)
    end

    def generate_row_event
      Generator::RowingEvent.new(athletes: @athletes)
    end

    def generate_olympic_event
      Generator::WeightLiftingMeet.new(
        type: Generator::OlympicMeet,
        athletes: @athletes
      )
    end

    def generate_powerlifting_event
      Generator::WeightLiftingMeet.new(
        type: Generator::PowerliftingMeet,
        athletes: @athletes
      )
    end

    def generate_event_type
      random_between(0..3)
    end
end
