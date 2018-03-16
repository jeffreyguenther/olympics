class Generator::DistanceEvent
  include Randomable

  SHORT = 500
  MEDIUM = 1000
  LONG = 5000

  attr_reader :results

  def initialize(athletes:, distance: nil, results: nil)
    @athletes = athletes
    @distance = distance || generate_distance
    @results = results || generate_athlete_performances
  end

  protected
    def generate_performance(distance, athlete)
      raise NotImplementedError
    end

    def movement_for_distance(distance)
      "#{distance}m #{movement_type}"
    end

    def movement
      raise NotImplementedError
    end

  private
    def generate_distance
       case generate_random_distance
       when 0
         SHORT
       when 1
         MEDIUM
       when 2
         LONG
       end
    end

    def generate_random_distance
      random_between(0..2)
    end

    def generate_athlete_performances
      @athletes.map{ |athlete| generate_performance(@distance, athlete)}
    end
end
