class AddMembershipTypeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :membership_type, :integer, default: 0, null: false
    remove_column :participations, :participation_type, :integer, default: 0, null: false
  end
end
