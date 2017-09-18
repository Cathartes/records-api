class CreateParticipations < ActiveRecord::Migration[5.1]
  def change
    create_table :participations do |t|
      t.belongs_to :record_book, null: false
      t.belongs_to :team, null: false
      t.belongs_to :user, null: false
      t.integer    :participation_type, null: false

      t.timestamps
    end
  end
end
