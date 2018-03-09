# == Schema Information
#
# Table name: attempts
#
#  id          :integer          not null, primary key
#  result      :integer
#  athlete_id  :integer
#  movement_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  event_id    :integer
#  success     :boolean          default(TRUE)
#  attempt     :integer
#
# Indexes
#
#  index_attempts_on_athlete_id   (athlete_id)
#  index_attempts_on_event_id     (event_id)
#  index_attempts_on_movement_id  (movement_id)
#  index_attempts_on_result       (result)
#

class Attempt < ApplicationRecord
  belongs_to :event
  belongs_to :athlete
  belongs_to :movement

  def self.succeeded
    where(success: true)
  end

  def self.failed
    where(success: false)
  end
end
