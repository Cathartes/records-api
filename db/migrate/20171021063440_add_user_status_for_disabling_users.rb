class AddUserStatusForDisablingUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :current_user_status, :integer, default: 0, null: false
  end
end
