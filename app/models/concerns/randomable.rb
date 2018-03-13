module Randomable
  extend ActiveSupport::Concern

  def random_between(range)
    @@prng ||= Random.new
    @@prng.rand(range)
  end
end
