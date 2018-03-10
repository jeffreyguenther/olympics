class Random::RowResult < Random::DistanceResult
  protected
    def generate_500m_time(speed)
      case speed
      when :slow
        generate_run_time_between(1.minute + 50.seconds..2.minutes + 30.seconds)
      when :medium
        generate_run_time_between(1.minute + 35.seconds..1.minute + 49.seconds)
      when :fast
        generate_run_time_between(1.minute + 34.seconds..1.minute + 15.seconds)
      end
    end

    def generate_1000m_time(speed)
      case speed
      when :slow
          generate_run_time_between(3.minutes + 40.seconds..5.minutes)
      when :medium
        generate_run_time_between(3.minute..3.minutes + 39.seconds)
      when :fast
        generate_run_time_between(2.minute + 40.seconds..2.minutes + 59.seconds)
      end
    end

    def generate_5000m_time(speed)
      case speed
      when :slow
          generate_run_time_between(20.minutes + 1.second..28.minutes)
      when :medium
        generate_run_time_between(15.minutes + 1.second..20.minutes)
      when :fast
        generate_run_time_between(13.minute + 30.seconds..15.minutes)
      end
    end
end
