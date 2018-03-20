class Stats::Summary::EventDistributionController < ApplicationController

  def show
    @events = Event.distribution
  end
end
