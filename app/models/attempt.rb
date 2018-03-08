# == Schema Information
#
# Table name: attempts
#
#  id                     :integer          not null, primary key
#  weight                 :integer
#  athlete_id             :integer
#  movement_id            :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  weighted_max_effort_id :integer
#  success                :boolean          default(FALSE)
#  attempt                :integer
#
# Indexes
#
#  index_attempts_on_athlete_id              (athlete_id)
#  index_attempts_on_movement_id             (movement_id)
#  index_attempts_on_weight                  (weight)
#  index_attempts_on_weighted_max_effort_id  (weighted_max_effort_id)
#

class Attempt < ApplicationRecord
  belongs_to :weighted_max_effort
  belongs_to :athlete
  belongs_to :movement

  def self.succeeded
    where(success: true)
  end

  def self.failed
    where(success: false)
  end
end
