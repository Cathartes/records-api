class RecordBook < ApplicationRecord
  has_many :challenges, dependent: :destroy

  validates :name, length: { minimum: 2, maximum: 24 }
  validates :published, boolean: true
  validates :time_zone, time_zone: true
  validates :start_time, :rush_start_time, timeliness: { type: :datetime }, allow_nil: true
  validates :end_time, timeliness: { type: :datetime, on_or_after: :start_time }, allow_nil: true
  validates :rush_end_time, timeliness: { type: :datetime, on_or_after: :rush_start_time }, allow_nil: true

  scope :published,   (-> { where published: true })
  scope :unpublished, (-> { where published: false })
end
