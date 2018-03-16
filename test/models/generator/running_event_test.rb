require 'test_helper'

class RunningEventTest < ActiveSupport::TestCase
  test "#movement_type" do
    event = Generator::RunningEvent.new(athletes: [])

    assert_equal "run", event.movement_type
  end

  test "generates performances for the athletes" do
    jim = Import::AthleteWithRecords.new(Athlete.create(name: "Jim"))
    bob = Import::AthleteWithRecords.new(Athlete.create(name: "Bob"))
    sam = Import::AthleteWithRecords.new(Athlete.create(name: "Sam"))
    athletes = [jim, bob, sam]

    event = Generator::RunningEvent.new(athletes: athletes)

    assert_equal athletes.count, event.results.count
  end

  test "Generates correct movement name for distance" do
    jim = Import::AthleteWithRecords.new(Athlete.create(name: "Jim"))
    athletes = [jim]

    event = Generator::RunningEvent.new(athletes: athletes, distance: 500)
    performance = event.results.first

    assert_equal "500m run", performance.movement
  end
end
