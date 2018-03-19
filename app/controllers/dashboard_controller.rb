class DashboardController < ApplicationController
  def show
    @overall_winner = Winner.overall
    @athletes = Athlete.all
    @movements = Movement.all

    @event_distribution = Event.distribution
  end
end
