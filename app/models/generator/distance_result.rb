class Generator::DistanceResult
  include Randomable

  attr_reader :speed, :distance

  def initialize(distance:, speed: nil, result: nil)
    @distance = distance
    @speed = speed || generate_speed
    @result = result || generate_time
  end

  # These methods allow DistanceResults
  # to quack like LiftAttempts
  def score
    @result.to_i
  end

  def attempt
    0
  end

  def success?
    true
  end

  protected
    # :nocov:
    def generate_500m_time(speed)
      raise NotImplementedError
    end
    # :nocov:

    # :nocov:
    def generate_1000m_time(speed)
      raise NotImplementedError
    end
    # :nocov:

    # :nocov:
    def generate_5000m_time(speed)
      raise NotImplementedError
    end
    # :nocov:

  private
    def generate_time
      case distance
      when Generator::DistanceEvent::SHORT
        generate_500m_time(speed)
      when Generator::DistanceEvent::MEDIUM
        generate_1000m_time(speed)
      when Generator::DistanceEvent::LONG
        generate_5000m_time(speed)
      end
    end

    def generate_run_time_between(range)
      random_between(range)
    end

    def generate_speed
      convert_speed_to_symbol(random_between(0..2))
    end

    def convert_speed_to_symbol(speed)
      case speed
      when 0
        :slow
      when 1
        :medium
      when 2
        :fast
      end
    end
end
