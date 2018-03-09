# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  kinds      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Event < ApplicationRecord
  enum kinds: { olympic: 0, power: 1}

  has_many :attempts

  def winners
    Athlete.joins(:attempts).where(
      attempts: {
        weight: attempts.succeeded.maximum(:weight),
        weighted_max_effort: self
      }
    )
  end
end
