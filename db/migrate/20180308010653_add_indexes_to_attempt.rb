class AddIndexesToAttempt < ActiveRecord::Migration[5.1]
  disable_ddl_transaction!
  
  def change
    add_index :attempts, :athlete_id, algorithm: :concurrently
    add_index :attempts, :movement_id, algorithm: :concurrently
    add_index :attempts, :weighted_max_effort_id, algorithm: :concurrently
    add_index :attempts, :weight, algorithm: :concurrently
  end
end
