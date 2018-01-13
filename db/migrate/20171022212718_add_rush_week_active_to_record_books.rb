# frozen_string_literal: true

class AddRushWeekActiveToRecordBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :record_books, :rush_week_active, :boolean, default: false, null: false
  end
end
