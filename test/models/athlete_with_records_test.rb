require 'test_helper'

class AthleteWithRecordsTest < ActiveSupport::TestCase
  test "returns id of athlete" do
    a = Athlete.create(name: "Bob")
    with_records = AthleteWithRecords.new(a)

    assert_equal a.id, with_records.id
  end

  test "returns previous record for movement" do
    previous = { "jump" => 100 }
    athlete = AthleteWithRecords.new(nil, previous)
    expected_opening_weight = previous["jump"] - 10

    assert_equal expected_opening_weight, athlete.opening_weight(nil, "jump")
  end

  test "generates random opening weight for movement" do
    expected_range = (100..185)
    with_records = AthleteWithRecords.new(nil)

    weight = with_records.opening_weight(OlympicMeet, "snatch")

    assert_includes expected_range, weight
    assert_equal 0, weight % 5
  end

  test "updates record given a better performance" do
    movement = "snatch"
    previous = { movement => 5 }
    athlete = AthleteWithRecords.new(nil, previous)
    attempts = [
      LiftAttempt.new(attempt: 0, weight: 100, result: LiftResult.new(attempt: 0, result: 0)),
      LiftAttempt.new(attempt: 1, weight: 105, result: LiftResult.new(attempt: 1, result: 0)),
      LiftAttempt.new(attempt: 2, weight: 110, result: LiftResult.new(attempt: 2, result: 1)),
    ]
    performance = LiftPerformance.new(starting_weight: 100, attempts: attempts)

    athlete.update_records_for(movement, performance)

    assert_equal 95, athlete.opening_weight(nil, movement)
  end

  test "skips update given a worse performance" do
    movement = "snatch"
    previous = { movement => 110 }
    athlete = AthleteWithRecords.new(nil, previous)
    attempts = [
      LiftAttempt.new(attempt: 0, weight: 100, result: LiftResult.new(attempt: 0, result: 0)),
      LiftAttempt.new(attempt: 1, weight: 105, result: LiftResult.new(attempt: 1, result: 0)),
      LiftAttempt.new(attempt: 2, weight: 110, result: LiftResult.new(attempt: 2, result: 1)),
    ]
    performance = LiftPerformance.new(starting_weight: nil, attempts: attempts)

    athlete.update_records_for(movement, performance)

    assert_equal 100, athlete.opening_weight(nil, movement)
  end

  test "skips update when all attempts are failures" do
    movement = "snatch"
    previous = { movement => 110 }
    athlete = AthleteWithRecords.new(nil, previous)
    attempts = [
      LiftAttempt.new(attempt: 0, weight: 100, result: LiftResult.new(attempt: 0, result: 3)),
      LiftAttempt.new(attempt: 1, weight: 100, result: LiftResult.new(attempt: 1, result: 3)),
      LiftAttempt.new(attempt: 2, weight: 100, result: LiftResult.new(attempt: 2, result: 3)),
    ]
    performance = LiftPerformance.new(starting_weight: nil, attempts: attempts)

    athlete.update_records_for(movement, performance)

    assert_equal 100, athlete.opening_weight(nil, movement)
  end
end