ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  def create_movements
    @run500m = Movement.create(name: "500m run")
    @run1000m = Movement.create(name: "1000m run")
    @run5000m = Movement.create(name: "5000m run")

    @row500m = Movement.create(name: "500m row")
    @row1000m =Movement.create(name: "1000m row")
    @row5000m =Movement.create(name: "5000m row")

    @squat = Movement.create(name: "squat")
    @bench = Movement.create(name: "bench")
    @deadlift = Movement.create(name: "deadlift")

    @clean_and_jerk = Movement.create(name: "clean and jerk")
    @snatch = Movement.create(name: "snatch")
  end
end
