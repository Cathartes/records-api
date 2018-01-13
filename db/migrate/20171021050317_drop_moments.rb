# frozen_string_literal: true

class DropMoments < ActiveRecord::Migration[5.1]
  def change
    drop_table :moments do |t|
      t.belongs_to :record_book, null: false
      t.belongs_to :trackable, polymorphic: true, null: false
      t.integer :moment_type, null: false

      t.timestamps
    end
  end
end
