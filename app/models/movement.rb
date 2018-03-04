# == Schema Information
#
# Table name: movements
#
#  id                     :integer          not null, primary key
#  weighted_max_effort_id :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#

class Movement < ApplicationRecord
  belongs_to :weighted_max_effort

  has_many :attempts
end
