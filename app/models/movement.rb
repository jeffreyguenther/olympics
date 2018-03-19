# == Schema Information
#
# Table name: movements
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#

class Movement < ApplicationRecord
  has_many :attempts

  def top_performance_by_max
    attempts.succeeded.maximum(:result)
  end

  def top_performance_by_min
    attempts.succeeded.minimum(:result)
  end

  def run?
    name.include?("run")
  end

  def row?
    name.include?("row")
  end

  def champions
    if row? || run?
      result = top_performance_by_min
    else
      result = top_performance_by_max
    end
    Athlete.joins(:attempts).where(attempts: {movement: self, success: true, result: result}).distinct
  end

  def athlete_top_performances
    results = Attempt.includes(:athlete).select("#{min_max} as result, athlete_id")
      .where(movement: self, success: true)
      .group(:athlete_id)
      .map { |a| [a.athlete, a.result] }

    Hash[results]
  end

  private
    def min_max
      if row? || run?
        "min(result)"
      else
        "max(result)"
      end
    end
end
