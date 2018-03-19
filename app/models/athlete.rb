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
    records = attempts.includes(:movement)
      .succeeded
      .select("MAX(result) as result, movement_id")
      .group(:movement_id)

    # Convert this to a union of the max results lifts and the min results for runs
    Hash[records.map { |r| [r.movement.name, r.result] }]
  end

  def lift_successes
    Attempt.succeeded
      .where(athlete: self)
      .group(:movement_id, :attempt)
      .having("movement_id IN (?)", 7..11)
      .order(:movement_id, :attempt)
      .count
  end

  def lift_failures
    Attempt.failed
      .where(athlete: self)
      .group(:movement_id, :attempt)
      .having("movement_id IN (?)", 7..11)
      .order(:movement_id, :attempt)
      .count
  end

  # Attempt.succeeded.where(athlete: Athlete.first).group(:movement_id, :attempt).having("movement_id IN (?)", 7..11).order(:movement_id, :attempt).count
end
