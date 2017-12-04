class AddChallengeTypeToChallenges < ActiveRecord::Migration[5.1]
  def change
    add_column :challenges, :challenge_type, :integer

    Challenge.reset_column_information
    Challenge.find_each do |challenge|
      type = challenge.max_completions.zero? ? :applicant : :member
      challenge.update! challenge_type: type
    end

    change_column_null :challenges, :challenge_type, false

    remove_column :challenges, :max_completions, :integer, null: false
  end
end
