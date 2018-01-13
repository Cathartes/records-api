# frozen_string_literal: true

class RemoveChallengeTypeFromChallenges < ActiveRecord::Migration[5.1]
  def change
    remove_column :challenges, :challenge_type, :integer
    add_column    :challenges, :max_completions, :integer

    Challenge.reset_column_information
    Challenge.find_each do |challenge|
      challenge.repeatable? ? challenge.update!(max_completions: 0) : challenge.update!(max_completions: 1)
    end

    remove_column      :challenges, :repeatable, :boolean
    change_column_null :challenges, :max_completions, false
  end
end
