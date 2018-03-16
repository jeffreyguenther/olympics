class CreateWinners < ActiveRecord::Migration[5.1]
  def change
    create_table :winners do |t|
      t.references :event, index: true, null: false, foreign_key: true
      t.references :athlete, index: true, null: false, foreign_key: true
      t.index [:event_id, :athlete_id]
      t.index [:athlete_id, :event_id]

      t.timestamps
    end
  end
end
