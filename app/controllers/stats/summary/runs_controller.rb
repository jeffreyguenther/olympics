class Stats::Summary::RunsController < ApplicationController

  def show
    @events = Event.distribution
  end
end
