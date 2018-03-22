# == Schema Information
#
# Table name: athletes
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class AthleteTest < ActiveSupport::TestCase
  test "#personal_records" do
    create_movements
    jim = Athlete.create(name: "jim")
    create(:attempt, :success, athlete: jim, movement: @squat, result: 10)
    create(:attempt, :success, athlete: jim, movement: @squat, result: 11)
    create(:attempt, :success, athlete: jim, movement: @run500m, result: 5)
    create(:attempt, :success, athlete: jim, movement: @run500m, result: 10)

    records = jim.personal_records

    assert_equal 11, records["squat"]
    assert_equal 5, records["500m run"]
  end

  test "#lift_successes_and_failures" do
    create_movements
    jim = Athlete.create(name: "jim")
    create(:attempt, :success, athlete: jim, movement: @squat, result: 10)
    create(:attempt, :success, athlete: jim, movement: @squat, result: 11)
    create(:attempt, :fail, athlete: jim, movement: @squat, result: 10)

    create(:attempt, :fail, athlete: jim, movement: @bench, result: 11)
    create(:attempt, :fail, athlete: jim, movement: @bench, result: 10)
    create(:attempt, :success, athlete: jim, movement: @bench, result: 11)

    attempts = jim.lift_successes_and_failures

    assert_equal 2, attempts[[@bench.id, 0, false]]
    assert_equal 1, attempts[[@bench.id, 0, true]]
    assert_equal 1, attempts[[@squat.id, 0, false]]
    assert_equal 2, attempts[[@squat.id, 0, true]]
  end
end
