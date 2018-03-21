class Stats::Summary::RowsController < ApplicationController

  def show
    @events = Event.distribution
  end
end
