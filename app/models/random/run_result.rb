class Random::RunResult < Random::DistanceResult
  protected
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
end
