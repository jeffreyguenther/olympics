# == Schema Information
#
# Table name: movements
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#

require 'test_helper'

class MovementTest < ActiveSupport::TestCase
  test "olympic_lifts" do
    create_movements

    assert_equal 2, Movement.olympic_lifts.count
  end

  test "powerlifts" do
    create_movements

    assert_equal 3, Movement.powerlifts.count
  end

  test "runs" do
    row = create(:movement, name: "500m row")
    run = create(:movement, name: "500m run")

    assert_includes Movement.runs, run
    assert_not_includes Movement.runs, row
  end

  test "rows" do
    row = create(:movement, name: "500m row")
    run = create(:movement, name: "500m run")

    assert_includes Movement.rows, row
    assert_not_includes Movement.rows, run
  end

  test "#top_performance_by_min" do
    movement = create(:movement)
    create(:attempt, :success, result: 10, movement: movement)
    create(:attempt, :success, result: 100, movement: movement)

    assert_equal 10, movement.top_performance_by_min
  end

  test "#top_performance_by_max" do
    movement = create(:movement)
    create(:attempt, :success, result: 10, movement: movement)
    create(:attempt, :success, result: 100, movement: movement)

    assert_equal 100, movement.top_performance_by_max
  end

  test "#run?" do
    movement = create(:movement, name: "500m run")

    assert movement.run?
  end

  test "#row?" do
    movement = create(:movement, name: "500m row")

    assert movement.row?
  end

  test "run champion" do
    jim = create(:athlete, name: "jim")
    bob = create(:athlete, name: "bob")
    movement = create(:movement, name: "500m run")
    create(:attempt, :success, movement: movement, athlete: jim, result: 100)
    create(:attempt, :success, movement: movement, athlete: bob, result: 10)

    assert_includes movement.champions, bob
  end

  test "lift champion" do
    jim = create(:athlete, name: "jim")
    bob = create(:athlete, name: "bob")
    movement = create(:movement, name: "lift")
    create(:attempt, :success, movement: movement, athlete: jim, result: 100)
    create(:attempt, :success, movement: movement, athlete: bob, result: 10)

    assert_includes movement.champions, jim
  end

  test "run athlete_top_performances" do
    jim = create(:athlete, name: "jim")
    bob = create(:athlete, name: "bob")
    movement = create(:movement, name: "500m run")
    create(:attempt, :success, movement: movement, athlete: jim, result: 100)
    create(:attempt, :success, movement: movement, athlete: jim, result: 500)
    create(:attempt, :success, movement: movement, athlete: bob, result: 10)
    create(:attempt, :success, movement: movement, athlete: bob, result: 100)

    performances = movement.athlete_top_performances

    assert_equal 100, performances[jim]
    assert_equal 10, performances[bob]
  end

  test "lift athlete_top_performances" do
    jim = create(:athlete, name: "jim")
    bob = create(:athlete, name: "bob")
    movement = create(:movement, name: "lift")
    create(:attempt, :success, movement: movement, athlete: jim, result: 100)
    create(:attempt, :success, movement: movement, athlete: jim, result: 500)
    create(:attempt, :success, movement: movement, athlete: bob, result: 10)
    create(:attempt, :success, movement: movement, athlete: bob, result: 100)

    performances = movement.athlete_top_performances

    assert_equal 500, performances[jim]
    assert_equal 100, performances[bob]
  end
end
