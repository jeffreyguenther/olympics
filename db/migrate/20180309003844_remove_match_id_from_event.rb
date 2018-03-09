class RemoveMatchIdFromEvent < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :match_id, :integer
  end
end
