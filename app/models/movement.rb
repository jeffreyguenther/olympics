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
  has_many :attempts

  def self.champion(movement)
    Athlete.joins(:attempts).where(
      attempts: {
        result: attempts.succeeded.where(movement: movement).maximum(:result)
      }
    )
  end

  def top_performance_by_max
    attempts.succeeded.maximum(:result)
  end

  def top_performance_by_min
    attempts.succeeded.minimum(:result)
  end
end
