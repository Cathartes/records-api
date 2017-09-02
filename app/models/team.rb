# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Team < ApplicationRecord
  has_many :participations, dependent: :destroy

  validates :name, length: { minimum: 2, maximum: 24 }

  def total_points_for_record_book(record_book)
    participations.for_record_book(record_book).joins(:completions).sum 'completions.points'
  end
end
