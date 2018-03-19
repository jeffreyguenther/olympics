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

class Winner < ApplicationRecord
  belongs_to :event
  belongs_to :athlete

  def self.wins_per_athlete
    includes(:athlete).select(:athlete_id)
    .group(:athlete_id)
    .count
  end

  def self.standings
    includes(:athlete).select(:athlete_id)
      .group(:athlete_id)
      .order("count(athlete_id) DESC")
  end

  def self.overall
    standings.first.athlete
  end
end
