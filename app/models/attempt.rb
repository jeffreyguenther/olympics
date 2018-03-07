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

class Attempt < ApplicationRecord
  belongs_to :weighted_max_effort
  belongs_to :athlete
  belongs_to :movement
end
