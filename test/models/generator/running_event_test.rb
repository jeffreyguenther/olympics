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

  test "#winners" do
    jim = Import::AthleteWithRecords.new(Athlete.create(name: "Jim"))
    bob = Import::AthleteWithRecords.new(Athlete.create(name: "Bob"))
    athletes = [jim, bob]
    movement = "500m run"

    results = [
      Generator::AthletePerformance.new(athlete: jim, movement: movement, score: 200, results: []),
      Generator::AthletePerformance.new(athlete: bob, movement: movement, score: 400, results: []),
    ]

    event = Generator::RunningEvent.new(athletes: athletes, distance: 500, results: results)

    assert_includes event.winners, jim
    assert_not_includes event.winners, bob
  end

  test "#winners returns multiple athletes in case of tie" do
    jim = Import::AthleteWithRecords.new(Athlete.create(name: "Jim"))
    bob = Import::AthleteWithRecords.new(Athlete.create(name: "Bob"))
    athletes = [jim, bob]
    movement = "500m run"

    results = [
      Generator::AthletePerformance.new(athlete: jim, movement: movement, score: 200, results: []),
      Generator::AthletePerformance.new(athlete: bob, movement: movement, score: 200, results: []),
    ]

    event = Generator::RunningEvent.new(athletes: athletes, distance: 500, results: results)

    assert_includes event.winners, jim
    assert_includes event.winners, bob
  end
end
