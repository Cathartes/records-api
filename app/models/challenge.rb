class Challenge < ApplicationRecord
  belongs_to :record_book

  validates :points, :record_book, presence: true
  validates :name, length: { minimum: 2, maximum: 24 }
  validates :max_completions, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, only_integer: true }

  scope :for_record_book, (->(record_book_id) { where record_book_id: record_book_id })
  scope :published,       (->                 { joins(:record_book).where record_books: { published: true } })
end
