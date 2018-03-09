class RefactorToSupportCardioEvents < ActiveRecord::Migration[5.1]
  def change
    rename_column :weighted_max_efforts, :lifts, :kinds
    rename_table :weighted_max_efforts, :events

    rename_column :attempts, :weight, :result
    rename_column :attempts, :weighted_max_effort_id, :event_id
    change_column_default :attempts, :success, from: false, to: true
  end
end
