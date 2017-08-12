class Team < ApplicationRecord
  has_many :participations, dependent: :destroy

  validates :name, length: { minimum: 2, maximum: 24 }
end
