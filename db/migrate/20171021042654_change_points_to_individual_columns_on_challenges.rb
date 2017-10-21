class ChangePointsToIndividualColumnsOnChallenges < ActiveRecord::Migration[5.1]
  def change
    remove_column :challenges, :points, :jsonb, default: {}, null: false

    add_column :challenges, :points_completion, :integer
    add_column :challenges, :points_first, :integer
    add_column :challenges, :points_second, :integer
    add_column :challenges, :points_third, :integer

    Challenge.reset_column_information
    Challenge.find_each { |challenge| challenge.update points_completion: 9 }

    change_column_null :challenges, :points_completion, false
  end
end
