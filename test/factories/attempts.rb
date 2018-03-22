# == Schema Information
#
# Table name: attempts
#
#  id          :integer          not null, primary key
#  result      :integer
#  athlete_id  :integer
#  movement_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  event_id    :integer
#  success     :boolean          default(TRUE)
#  attempt     :integer
#
# Indexes
#
#  index_attempts_on_athlete_id              (athlete_id)
#  index_attempts_on_event_id                (event_id)
#  index_attempts_on_movement_id             (movement_id)
#  index_attempts_on_movement_id_and_result  (movement_id,result)
#  index_attempts_on_result                  (result)
#

FactoryBot.define do
  factory :attempt do
    result 100
    movement
    event
    athlete

    trait :fail do
      success false
    end

    trait :success do
      success true
    end
  end
end
