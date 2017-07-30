class Challenge < ApplicationRecord
  belongs_to :record_book

  enum challenge_type: { members: 0, applicants: 1, everyone: 2 }

  validates :challenge_type, :points, :record_book, presence: true
  validates :name, length: { minimum: 2, maximum: 24 }
  validates :repeatable, boolean: true

  scope :for_record_book, (->(record_book_id) { where record_book_id: record_book_id })
  scope :published,       (->                 { joins(:record_book).where record_books: { published: true } })
end
