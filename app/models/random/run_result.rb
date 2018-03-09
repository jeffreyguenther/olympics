class Random::RunResult
  attr_reader :speed, :distance

  def initialize(distance:, speed: nil, result: nil)
    @distance = distance
    @speed = speed || generate_speed
    @result = result || generate_time
  end

  def result
    @result.to_i
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

    def generate_500m_time(speed)
      case speed
      when :slow
          generate_run_time_between(1.minute + 16.seconds..2.minutes)
      when :medium
        generate_run_time_between(56.seconds..1.minute + 15.seconds)
      when :fast
        generate_run_time_between(40.seconds..55.seconds)
      end
    end

    def generate_1000m_time(speed)
      case speed
      when :slow
          generate_run_time_between(3.minutes + 31.seconds..5.minutes)
      when :medium
        generate_run_time_between(2.minute + 51.seconds..3.minutes + 30.seconds)
      when :fast
        generate_run_time_between(2.minute + 20.seconds..2.minutes + 50.seconds)
      end
    end

    def generate_5000m_time(speed)
      case speed
      when :slow
          generate_run_time_between(20.minutes + 1.seconds..28.minutes)
      when :medium
        generate_run_time_between(15.minute + 1.seconds..20.minutes)
      when :fast
        generate_run_time_between(13.minute + 30.seconds..15.minutes)
      end
    end

    def generate_run_time_between(range)
      random_between(range)
    end

    def generate_speed
      convert_speed_to_symbol(random_between(0..3))
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
