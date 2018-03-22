class Stats::Summary::RowsController < ApplicationController

  def show
    @athletes = Athlete.all
    @movement = Movement.find(params[:id])
  end
end
