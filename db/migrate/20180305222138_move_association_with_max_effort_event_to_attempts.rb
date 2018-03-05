class MoveAssociationWithMaxEffortEventToAttempts < ActiveRecord::Migration[5.1]
  def change
    remove_column :movements, :weighted_max_effort_id, :integer
    add_column :attempts, :weighted_max_effort_id, :integer
    add_column :attempts, :success, :boolean, default: false
  end
end
