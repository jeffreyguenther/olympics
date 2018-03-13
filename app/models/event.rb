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

  def self.distribution_of_events
    Event.group(:kinds).count
  end

  def winners
    Athlete.joins(:attempts).where(
      attempts: {
        result: attempts.succeeded.maximum(:result),
        event: self
      }
    )
  end
end
