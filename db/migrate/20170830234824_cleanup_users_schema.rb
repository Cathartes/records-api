class CleanupUsersSchema < ActiveRecord::Migration[5.1]
  def change
    change_column_null :users, :password_digest, true
    add_column         :users, :password_updated_at, :datetime
  end
end
