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

FactoryBot.define do
  factory :attempt do
    weight 1
    athlete_id 1
    movement_id 1
  end
end
