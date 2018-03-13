require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "Generate random event and athlete performances" do
    jim = Import::AthleteWithRecords.new(Athlete.create(name: "Jim"))
    bob = Import::AthleteWithRecords.new(Athlete.create(name: "Bob"))
    athletes = [jim, bob]

    event = Generator::Event.new(athletes: athletes)
    results_per_athlete =  event.performances.group_by(&:athlete)

    assert_equal athletes.count, results_per_athlete.count
  end

  test "#type" do
    expected_event_type = 2
    event = Generator::Event.new(athletes: [], type: expected_event_type)

    assert_equal expected_event_type, event.type
  end

  test "generates olympic event" do
    jim = Import::AthleteWithRecords.new(Athlete.create(name: "Jim"))
    bob = Import::AthleteWithRecords.new(Athlete.create(name: "Bob"))
    athletes = [jim, bob]
    event = Generator::Event.new(athletes: athletes, type: 0)

    assert_equal athletes.count * 2, event.performances.count
  end

  test "generates powerlifting event" do
    jim = Import::AthleteWithRecords.new(Athlete.create(name: "Jim"))
    bob = Import::AthleteWithRecords.new(Athlete.create(name: "Bob"))
    athletes = [jim, bob]
    event = Generator::Event.new(athletes: athletes, type: 1)

    assert_equal athletes.count * 3, event.performances.count
  end

  test "generates run event" do
    jim = Import::AthleteWithRecords.new(Athlete.create(name: "Jim"))
    bob = Import::AthleteWithRecords.new(Athlete.create(name: "Bob"))
    athletes = [jim, bob]
    event = Generator::Event.new(athletes: athletes, type: 2)

    assert_equal athletes.count, event.performances.count
  end

  test "generates row event" do
    jim = Import::AthleteWithRecords.new(Athlete.create(name: "Jim"))
    bob = Import::AthleteWithRecords.new(Athlete.create(name: "Bob"))
    athletes = [jim, bob]
    event = Generator::Event.new(athletes: athletes, type: 3)

    assert_equal athletes.count, event.performances.count
  end
end
