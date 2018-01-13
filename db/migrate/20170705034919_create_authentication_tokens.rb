# frozen_string_literal: true

class CreateAuthenticationTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :authentication_tokens do |t|
      t.belongs_to :user, null: false
      t.string     :body, null: false

      t.timestamps
    end
  end
end
