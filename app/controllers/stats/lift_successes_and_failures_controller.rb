class Stats::LiftSuccessesAndFailuresController < ApplicationController
  def show
    @athlete = Athlete.find(params[:id])
    @success_and_failures = @athlete.lift_successes_and_failures
    @movements = Movement.where(id: Movement.powerlifts.union(Movement.olympic_lifts))
  end
end
