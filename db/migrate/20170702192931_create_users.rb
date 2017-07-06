class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email

      t.string :discord_name, null: false
      t.string :password_digest, null: false

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email

      t.boolean :admin, default: false, null: false

      t.index :email, unique: true
      t.index :discord_name, unique: true
      t.index :reset_password_token, unique: true
      t.index :confirmation_token, unique: true

      t.timestamps
    end
  end
end
