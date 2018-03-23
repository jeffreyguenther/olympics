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
  test "wins per athlete" do
    bob = create(:athlete, name: "bob")
    jim = create(:athlete, name: "jim")

    event1 = create(:event)
    event2 = create(:event)

    create(:winner, event: event1, athlete: jim)
    create(:winner, event: event1, athlete: bob)
    create(:winner, event: event2, athlete: bob)

    wins = Winner.wins_per_athlete

    assert_equal 1, wins[jim.id]
    assert_equal 2, wins[bob.id]
  end

  test "overall" do
    bob = create(:athlete, name: "bob")
    jim = create(:athlete, name: "jim")

    event1 = create(:event)
    event2 = create(:event)

    create(:winner, event: event1, athlete: jim)
    create(:winner, event: event1, athlete: bob)
    create(:winner, event: event2, athlete: bob)
    create(:winner, athlete: bob)

    assert_equal bob, Winner.overall
  end

  test "wins per athlete per event type" do
    bob = create(:athlete, name: "bob")
    jim = create(:athlete, name: "jim")

    zero1 = create(:event, kinds: 0)
    create(:winner, event: zero1, athlete: jim)

    zero2 = create(:event, kinds: 0)
    create(:winner, event: zero2, athlete: bob)

    one = create(:event, kinds: 1)
    create(:winner, event: one, athlete: bob)

    distribution = Winner.wins_per_athlete_per_event
    zero_counts = distribution[0].group_by{|w| w.athlete }
    one_counts = distribution[1].group_by{|w| w.athlete }

    assert_equal 1, zero_counts[jim].first.wins
    assert_equal 1, zero_counts[bob].first.wins
    assert_equal 1, one_counts[bob].first.wins
  end
end
