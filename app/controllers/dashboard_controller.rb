class DashboardController < ApplicationController
  def show
    @athletes = Athlete.all
    @movements = Movement.all

    @event_distribution = Event.distribution_of_events
  end
end
