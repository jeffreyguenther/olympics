# == Schema Information
#
# Table name: movements
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#

FactoryBot.define do
  factory :movement do
    name "run"
  end
end
