class AddStatusToCompletions < ActiveRecord::Migration[5.1]
  def change
    add_column :completions, :status, :integer, default: 0, null: false
  end
end
