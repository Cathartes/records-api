# == Schema Information
#
# Table name: challenges
#
#  id              :integer          not null, primary key
#  record_book_id  :integer          not null
#  name            :string           not null
#  points          :jsonb            not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  max_completions :integer          not null
#
# Indexes
#
#  index_challenges_on_record_book_id  (record_book_id)
#

class Challenge < ApplicationRecord
  belongs_to :record_book

  has_many :completions, dependent: :destroy

  validates :points, :record_book, presence: true
  validates :name, length: { minimum: 2, maximum: 24 }
  validates :max_completions, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, only_integer: true }

  scope :for_record_book, (->(record_book_id) { where record_book_id: record_book_id })
  scope :published,       (->                 { joins(:record_book).where record_books: { published: true } })

  def points_for_rank(rank)
    Rails.logger.debug points
    Rails.logger.debug rank
    points[rank.to_s] || points['0']
  end
end
