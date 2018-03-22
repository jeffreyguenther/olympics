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
  RUN_ROW_IDS = (1..6).to_a
  LIFT_IDS = (7..11).to_a

  has_many :attempts
  has_many :events, through: :attempts, source: :event

  def self.olympic_lifts
    where(name: Generator::OlympicMeet.movements)
  end

  def self.powerlifts
    where(name: Generator::PowerliftingMeet.movements)
  end

  def self.runs
    where("name ILIKE '%run'")
  end

  def self.rows
    where("name ILIKE '%row'")
  end

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

    Athlete.joins(:attempts)
      .where(attempts: {movement: self, success: true, result: result})
      .distinct
  end

  def athlete_top_performances
    results = Attempt.includes(:athlete)
      .select("#{min_max} as result, athlete_id")
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
