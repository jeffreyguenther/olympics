class CreateAttempts < ActiveRecord::Migration[5.1]
  def change
    create_table :attempts do |t|
      t.integer :weight
      t.integer :athlete_id
      t.integer :movement_id

      t.timestamps
    end
  end
end
