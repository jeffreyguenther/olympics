class CreateMovements < ActiveRecord::Migration[5.1]
  def change
    create_table :movements do |t|
      t.integer :weighted_max_effort_id

      t.timestamps
    end
  end
end
