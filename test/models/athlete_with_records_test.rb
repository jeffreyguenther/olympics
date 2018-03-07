require 'test_helper'

class AthleteWithRecordsTest < ActiveSupport::TestCase
  test "returns id of athlete" do
    a = Athlete.create(name: "Bob")
    with_records = AthleteWithRecords.new(a)

    assert_equal with_records.id, a.id
  end

  test "returns previous record for movement" do
    previous = { "jump" => 100 }
    athlete = AthleteWithRecords.new(nil, previous)

    assert_equal athlete.opening_weight(nil, "jump"), previous["jump"]
  end

  test "generates random opening weight for movement" do
    expected_range = (100..185)
    with_records = AthleteWithRecords.new(nil)

    weight = with_records.opening_weight(OlympicMeet, "snatch")

    assert_includes expected_range, weight
    assert_equal weight % 5, 0
  end

  test "updates record given a performance" do
    movement = "snatch"
    previous = { movement => 5 }
    athlete = AthleteWithRecords.new(nil)
    performance = LiftPerformance.new(starting_weight: 100)
    performance.generate

    athlete.update_records_for(movement, performance)

    assert_not_equal athlete.opening_weight(nil, movement), 5
  end
end
