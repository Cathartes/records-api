class Completion < ApplicationRecord
  belongs_to :challenge
  belongs_to :participation

  has_one :user, through: :participation

  validates :challenge, :participation, presence: true
  validates :rank, numericality: { greater_than: 0, less_than_or_equal_to: 100, only_integer: true }
  validates :points, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, only_integer: true }

  scope :for_participation, (->(participation_id) { where participation_id: participation_id })
  scope :for_user,          (->(user_id)          { joins(:participation).where participations: { user_id: user_id } })
end