# == Schema Information
#
# Table name: athletes
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Athlete < ApplicationRecord
  has_many :attempts
  has_many :winners
  has_many :events_won, through: :winners, source: :event

  def personal_records
    lifts = attempts.includes(:movement)
      .succeeded
      .select("MAX(result) as result, movement_id")
      .where(attempts: {movement: Movement.olympic_lifts.union(Movement.powerlifts)})
      .group(:movement_id)

    runs_rows = attempts.includes(:movement)
      .succeeded
      .select("MIN(result) as result, movement_id")
      .where(attempts: {movement: Movement.runs.union(Movement.rows)})
      .group(:movement_id)

    records = lifts.to_a + runs_rows.to_a

    Hash[records.map { |r| [r.movement.name, r.result] }]
  end

  def lift_successes_and_failures
    Attempt
      .where(athlete: self)
      .group(:movement_id, :attempt, :success)
      .having(movement: Movement.olympic_lifts.union(Movement.powerlifts))
      .order(:movement_id, :attempt)
      .count
  end
end
