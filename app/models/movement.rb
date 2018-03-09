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
end
