# == Schema Information
#
# Table name: completions
#
#  id               :integer          not null, primary key
#  challenge_id     :integer          not null
#  participation_id :integer          not null
#  rank             :integer          not null
#  points           :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  status           :integer          default("pending"), not null
#
# Indexes
#
#  index_completions_on_challenge_id      (challenge_id)
#  index_completions_on_participation_id  (participation_id)
#

class Completion < ApplicationRecord
  belongs_to :challenge, counter_cache: true
  belongs_to :participation

  has_one :record_book, through: :participation
  has_one :user, through: :participation

  enum status: { pending: 0, approved: 1, declined: 2 }

  validates :challenge, :participation, :status, presence: true
  validates :rank, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 3, only_integer: true }
  validates :points, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  before_validation :assign_rank, on: :create, unless: :rank
  before_validation :assign_points, on: :create, unless: :points

  scope :for_participation, (->(participation_id) { where participation_id: participation_id })
  scope :for_user,          (->(user_id)          { joins(:participation).where participations: { user_id: user_id } })

  scope :for_record_book, (lambda do |record_book_id|
    joins(:participation).where participations: { record_book_id: record_book_id }
  end)

  private

  def assign_points
    self.points = challenge&.points_for_rank rank
  end

  def assign_rank
    return if challenge.blank?
    previous_rank = challenge.completions.order(:rank).last&.rank || 0
    self.rank = previous_rank + 1
  end
end
