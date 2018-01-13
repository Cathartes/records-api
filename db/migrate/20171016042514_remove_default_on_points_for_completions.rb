# frozen_string_literal: true

class RemoveDefaultOnPointsForCompletions < ActiveRecord::Migration[5.1]
  def change
    change_column_default :completions, :points, from: 0, to: nil
  end
end
