# == Schema Information
#
# Table name: completions
#
#  id               :integer          not null, primary key
#  challenge_id     :integer          not null
#  participation_id :integer          not null
#  rank             :integer          not null
#  points           :integer          default(0), not null
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
  include Trackable

  belongs_to :challenge
  belongs_to :participation

  has_one :record_book, through: :participation
  has_one :user, through: :participation

  enum status: { pending: 0, approved: 1, declined: 2 }

  validates :challenge, :participation, :status, presence: true
  validates :rank, numericality: { greater_than: 0, less_than_or_equal_to: 100, only_integer: true }
  validates :points, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, only_integer: true }

  scope :for_participation, (->(participation_id) { where participation_id: participation_id })
  scope :for_user,          (->(user_id)          { joins(:participation).where participations: { user_id: user_id } })

  private

  def on_create_moment
    build_moment moment_type: :completion, record_book: record_book
  end
end
