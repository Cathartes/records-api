# == Schema Information
#
# Table name: record_books
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  published       :boolean          default(FALSE), not null
#  time_zone       :string           default("UTC"), not null
#  start_time      :datetime
#  end_time        :datetime
#  rush_start_time :datetime
#  rush_end_time   :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class RecordBook < ApplicationRecord
  has_many :challenges, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :teams, through: :participations

  validates :name, length: { minimum: 2, maximum: 24 }
  validates :published, boolean: true
  validates :time_zone, time_zone: true
  validates :start_time, :rush_start_time, timeliness: { type: :datetime }, allow_nil: true
  validates :end_time, timeliness: { type: :datetime, on_or_after: :start_time }, allow_nil: true
  validates :rush_end_time, timeliness: { type: :datetime, on_or_after: :rush_start_time }, allow_nil: true

  scope :published,   (-> { where published: true })
  scope :unpublished, (-> { where published: false })
end
