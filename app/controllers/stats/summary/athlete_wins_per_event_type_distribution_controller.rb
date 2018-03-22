class Stats::Summary::AthleteWinsPerEventTypeDistributionController < ApplicationController

  def show
    @wins = Winner.wins_per_athlete_per_event.group_by{|w| w.event_kind}
    @event_types = Event.kinds.values
  end
end
