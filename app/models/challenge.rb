# == Schema Information
#
# Table name: challenges
#
#  id                :integer          not null, primary key
#  record_book_id    :integer          not null
#  name              :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  points_completion :integer          not null
#  points_first      :integer
#  points_second     :integer
#  points_third      :integer
#  completions_count :integer          default(0), not null
#  position          :integer          not null
#  challenge_type    :integer          not null
#
# Indexes
#
#  index_challenges_on_record_book_id  (record_book_id)
#

class Challenge < ApplicationRecord
  belongs_to :record_book

  has_many :completions, dependent: :destroy

  enum challenge_type: { everyone: 0, applicant: 1, member: 2 }

  acts_as_list scope: :record_book

  validates :challenge_type, :record_book, presence: true
  validates :name, length: { minimum: 2, maximum: 24 }
  validates :points_completion, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  scope :for_record_book, (->(record_book_id) { where record_book_id: record_book_id })
  scope :published,       (->                 { joins(:record_book).where record_books: { published: true } })

  def points_for_rank(rank)
    [points_completion, points_first, points_second, points_third][rank] || points_completion
  end
end
