class Stats::Summary::AthleteEventWinsController < ApplicationController

  def index
    @wins = wins_per_athlete
  end

  private
    def wins_per_athlete
      Winner.wins_per_athlete
        .transform_keys { |k| Athlete.find(k)}
    end
end
