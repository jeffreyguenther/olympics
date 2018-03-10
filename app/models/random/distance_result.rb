class Random::DistanceResult
  attr_reader :speed, :distance

  def initialize(distance:, speed: nil, result: nil)
    @distance = distance
    @speed = speed || generate_speed
    @result = result || generate_time
  end

  def result
    @result.to_i
  end

  protected
    def generate_500m_time(speed)
      raise NotImplementedError
    end

    def generate_1000m_time(speed)
      raise NotImplementedError
    end

    def generate_5000m_time(speed)
      raise NotImplementedError
    end

  private
    def generate_time
      case distance
      when 500
        generate_500m_time(speed)
      when 1000
        generate_1000m_time(speed)
      when 5000
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

    def random_between(range)
      @@prng ||= Random.new
      @@prng.rand(range)
    end
end
