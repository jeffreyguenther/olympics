class DashboardController < ApplicationController
  def show
    @athletes = Athlete.all
    @movements = Movement.all
  end
end
