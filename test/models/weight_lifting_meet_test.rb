require 'test_helper'

class WeightLiftingMeetTest < ActiveSupport::TestCase
  test "generates performances olympic meet" do
    jim = Import::AthleteWithRecords.new(Athlete.create(name: "Jim"))
    bob = Import::AthleteWithRecords.new(Athlete.create(name: "Bob"))
    athletes = [jim, bob]

    meet = Random::WeightLiftingMeet.new(type: Random::OlympicMeet, athletes: athletes)
    results = meet.results

    assert_equal 2, results[jim].count
    assert_equal 2, results[bob].count
  end

  test "generates performances powerlifting meet" do
    jim = Import::AthleteWithRecords.new(Athlete.create(name: "Jim"))
    bob = Import::AthleteWithRecords.new(Athlete.create(name: "Bob"))
    athletes = [jim, bob]

    meet = Random::WeightLiftingMeet.new(type: Random::PowerliftingMeet, athletes: athletes)
    results = meet.results

    assert_equal 3, results[jim].count
    assert_equal 3, results[bob].count
  end
end
