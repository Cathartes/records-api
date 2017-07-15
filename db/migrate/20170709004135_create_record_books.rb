class CreateRecordBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :record_books do |t|
      t.string   :name, null: false
      t.boolean  :published, default: false, null: false
      t.string   :time_zone, default: 'UTC', null: false
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :rush_start_time
      t.datetime :rush_end_time

      t.timestamps
    end
  end
end
