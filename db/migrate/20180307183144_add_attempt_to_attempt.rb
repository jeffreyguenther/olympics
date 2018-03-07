class AddAttemptToAttempt < ActiveRecord::Migration[5.1]
  def change
    add_column :attempts, :attempt, :integer
  end
end
