# frozen_string_literal: true

class CreateChallenges < ActiveRecord::Migration[5.1]
  def change
    create_table :challenges do |t|
      t.belongs_to :record_book, null: false
      t.string     :name, null: false
      t.integer    :challenge_type, null: false
      t.boolean    :repeatable, default: false, null: false
      t.jsonb      :points, default: {}, null: false

      t.timestamps
    end
  end
end
