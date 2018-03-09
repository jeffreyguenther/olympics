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
  enum kinds: { olympic: 0, power: 1, run: 2, row: 3}

  has_many :attempts

  def winners
    Athlete.joins(:attempts).where(
      attempts: {
        weight: attempts.succeeded.maximum(:weight),
        event: self
      }
    )
  end
end
