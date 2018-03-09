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

FactoryBot.define do
  factory :event do
    kinds 1
  end
end
