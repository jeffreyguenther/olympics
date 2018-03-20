class Stats::MovementMaximumsController < ApplicationController
  def show
    @movement = Movement.find(params[:id])
    @performances = @movement.athlete_top_performances.to_a
  end
end
