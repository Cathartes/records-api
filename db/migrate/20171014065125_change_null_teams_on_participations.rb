# frozen_string_literal: true

class ChangeNullTeamsOnParticipations < ActiveRecord::Migration[5.1]
  def change
    change_column_null :participations, :team_id, true
  end
end
