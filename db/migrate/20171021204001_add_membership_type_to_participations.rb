class AddMembershipTypeToParticipations < ActiveRecord::Migration[5.1]
  def change
    add_column :participations, :membership_type, :integer

    Participation.reset_column_information
    Participation.includes(:user).find_each do |participation|
      participation.update membership_type: user.membership_type
    end

    change_column_null :participations, :membership_type, false
  end
end
