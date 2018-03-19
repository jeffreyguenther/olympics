class AddResultMovementIndexToAttempts < ActiveRecord::Migration[5.1]
  disable_ddl_transaction!

  def change
    add_index :attempts, [:movement_id, :result], algorithm: :concurrently
  end
end
