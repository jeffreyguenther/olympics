require 'test_helper'

class RowingEventTest < ActiveSupport::TestCase
  test "#movement" do
    event = Generator::RowingEvent.new(athletes: [])

    assert_equal "row", event.movement
  end

  test "generates performances for the athletes" do
    jim = Import::AthleteWithRecords.new(Athlete.create(name: "Jim"))
    bob = Import::AthleteWithRecords.new(Athlete.create(name: "Bob"))
    sam = Import::AthleteWithRecords.new(Athlete.create(name: "Sam"))
    athletes = [jim, bob, sam]

    event = Generator::RowingEvent.new(athletes: athletes)

    assert_equal athletes.count, event.results.count
  end
end
