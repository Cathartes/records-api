# frozen_string_literal: true

class AddCompletionsCountToChallenges < ActiveRecord::Migration[5.1]
  def change
    add_column :challenges, :completions_count, :integer, default: 0, null: false

    Challenge.reset_column_information
    Challenge.find_each.pluck(:id) { |challenge_id| Challenge.reset_counters challenge_id, :completions }
  end
end
