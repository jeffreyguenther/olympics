# == Schema Information
#
# Table name: attempts
#
#  id          :integer          not null, primary key
#  result      :integer
#  athlete_id  :integer
#  movement_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  event_id    :integer
#  success     :boolean          default(TRUE)
#  attempt     :integer
#
# Indexes
#
#  index_attempts_on_athlete_id              (athlete_id)
#  index_attempts_on_event_id                (event_id)
#  index_attempts_on_movement_id             (movement_id)
#  index_attempts_on_movement_id_and_result  (movement_id,result)
#  index_attempts_on_result                  (result)
#

require 'test_helper'

class AttemptTest < ActiveSupport::TestCase
  test "succeeded" do
    success = create(:attempt, :success)
    failure = create(:attempt, :fail)

    assert_includes Attempt.succeeded, success
    assert_not_includes Attempt.succeeded, failure
  end

  test "failed" do
    success = create(:attempt, :success)
    failure = create(:attempt, :fail)

    assert_not_includes Attempt.failed, success
    assert_includes Attempt.failed, failure
  end
end
