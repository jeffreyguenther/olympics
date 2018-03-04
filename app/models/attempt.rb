# == Schema Information
#
# Table name: attempts
#
#  id          :integer          not null, primary key
#  weight      :integer
#  athlete_id  :integer
#  movement_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Attempt < ApplicationRecord
  belongs_to :athlete
  belongs_to :movement
end
