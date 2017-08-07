class CreateCompletions < ActiveRecord::Migration[5.1]
  def change
    create_table :completions do |t|
      t.belongs_to :challenge,          null: false
      t.belongs_to :participation,      null: false
      t.integer    :rank,               null: false
      t.integer    :points, default: 0, null: false

      t.timestamps
    end
  end
end
