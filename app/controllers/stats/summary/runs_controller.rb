class Stats::Summary::RunsController < ApplicationController

  def show
    @athletes = Athlete.all
    @movement = Movement.find(params[:id])
  end
end
