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

  def personal_records
    records = attempts.includes(:movement)
      .succeeded
      .select("MAX(result) as result, movement_id")
      .group(:movement_id)

    Hash[records.map { |r| [r.movement.name, r.result] }]
  end
end
