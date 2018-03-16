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
  has_many :winners
  has_many :winning_athletes, through: :winners, source: :athlete

  def self.distribution_of_events
    Event.group(:kinds).count
  end
end
