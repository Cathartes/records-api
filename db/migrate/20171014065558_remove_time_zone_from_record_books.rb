class RemoveTimeZoneFromRecordBooks < ActiveRecord::Migration[5.1]
  def change
    remove_column :record_books, :time_zone, :string, default: 'UTC', null: false
  end
end
