require 'test_helper'

class WeightLiftingMeetTest < ActiveSupport::TestCase
  test "generates performances olympic meet" do
    jim = AthleteWithRecords.new(Athlete.create(name: "Jim"))
    bob = AthleteWithRecords.new(Athlete.create(name: "Bob"))
    athletes = [jim, bob]

    meet = WeightLiftingMeet.new(type: OlympicMeet, athletes: athletes)
    results = meet.results

    assert_equal 2, results[jim].count
    assert_equal 2, results[bob].count
  end

  test "generates performances powerlifting meet" do
    jim = AthleteWithRecords.new(Athlete.create(name: "Jim"))
    bob = AthleteWithRecords.new(Athlete.create(name: "Bob"))
    athletes = [jim, bob]

    meet = WeightLiftingMeet.new(type: PowerliftingMeet, athletes: athletes)
    results = meet.results

    assert_equal 3, results[jim].count
    assert_equal 3, results[bob].count
  end
end
