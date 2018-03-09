# == Schema Information
#
# Table name: weighted_max_efforts
#
#  id         :integer          not null, primary key
#  lifts      :integer
#  match_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Meet < ApplicationRecord
  enum lifts: { olympic: 0, power: 1}

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
