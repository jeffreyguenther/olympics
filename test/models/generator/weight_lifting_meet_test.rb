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
end
