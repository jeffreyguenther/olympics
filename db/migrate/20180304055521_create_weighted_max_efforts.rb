class CreateWeightedMaxEfforts < ActiveRecord::Migration[5.1]
  def change
    create_table :weighted_max_efforts do |t|
      t.integer :lifts
      t.integer :match_id

      t.timestamps
    end
  end
end
