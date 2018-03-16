# == Schema Information
#
# Table name: winners
#
#  id         :integer          not null, primary key
#  event_id   :integer          not null
#  athlete_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_winners_on_athlete_id               (athlete_id)
#  index_winners_on_athlete_id_and_event_id  (athlete_id,event_id)
#  index_winners_on_event_id                 (event_id)
#  index_winners_on_event_id_and_athlete_id  (event_id,athlete_id)
#
# Foreign Keys
#
#  fk_rails_...  (athlete_id => athletes.id)
#  fk_rails_...  (event_id => events.id)
#

require 'test_helper'

class WinnerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
