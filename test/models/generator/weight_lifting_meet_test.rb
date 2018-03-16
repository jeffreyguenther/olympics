require 'test_helper'

class WeightLiftingMeetTest < ActiveSupport::TestCase
  test "generates performances olympic meet" do
    jim = Import::AthleteWithRecords.new(Athlete.create(name: "Jim"))
    bob = Import::AthleteWithRecords.new(Athlete.create(name: "Bob"))
    athletes = [jim, bob]

    meet = Generator::WeightLiftingMeet.new(type: Generator::OlympicMeet, athletes: athletes)
    results = meet.results

    assert_equal 4, results.count
  end

  test "generates performances powerlifting meet" do
    jim = Import::AthleteWithRecords.new(Athlete.create(name: "Jim"))
    bob = Import::AthleteWithRecords.new(Athlete.create(name: "Bob"))
    athletes = [jim, bob]

    meet = Generator::WeightLiftingMeet.new(type: Generator::PowerliftingMeet, athletes: athletes)
    results = meet.results

    assert_equal 6, results.count
  end

  test "#winner" do
    jim = Import::AthleteWithRecords.new(Athlete.create(name: "Jim"))
    bob = Import::AthleteWithRecords.new(Athlete.create(name: "Bob"))
    athletes = [jim, bob]

    results = Generator::PowerliftingMeet.movements.map do |movement|
      [
        Generator::AthletePerformance.new(athlete: jim, movement: movement, score: 200, results: []),
        Generator::AthletePerformance.new(athlete: bob, movement: movement, score: 400, results: []),
      ]
    end

    event = Generator::WeightLiftingMeet.new(
      type: Generator::PowerliftingMeet,
      athletes: athletes,
      performances: results.flatten
    )

    assert_includes event.winners, bob
    assert_not_includes event.winners, jim
  end

  test "#winner returns multiple athletes in the case of a tie" do
    jim = Import::AthleteWithRecords.new(Athlete.create(name: "Jim"))
    bob = Import::AthleteWithRecords.new(Athlete.create(name: "Bob"))
    athletes = [jim, bob]

    results = Generator::PowerliftingMeet.movements.map do |movement|
      [
        Generator::AthletePerformance.new(athlete: jim, movement: movement, score: 400, results: []),
        Generator::AthletePerformance.new(athlete: bob, movement: movement, score: 400, results: []),
      ]
    end

    event = Generator::WeightLiftingMeet.new(
      type: Generator::PowerliftingMeet,
      athletes: athletes,
      performances: results.flatten
    )

    assert_includes event.winners, jim
    assert_includes event.winners, bob
  end
end
