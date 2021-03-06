# frozen_string_literal: true

# == Schema Information
#
# Table name: participations
#
#  id              :integer          not null, primary key
#  record_book_id  :integer          not null
#  team_id         :integer
#  user_id         :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  membership_type :integer          not null
#
# Indexes
#
#  index_participations_on_record_book_id  (record_book_id)
#  index_participations_on_team_id         (team_id)
#  index_participations_on_user_id         (user_id)
#

class Participation < ApplicationRecord
  belongs_to :record_book
  belongs_to :team, optional: true
  belongs_to :user

  has_many :completions, dependent: :destroy

  enum membership_type: { applicant: 0, member: 1 }

  validates :membership_type, :record_book, :user, presence: true
  validates :user_id, uniqueness: { scope: :record_book_id }

  before_validation :set_membership_type, on: :create

  scope :for_record_book, (->(record_book_id) { where record_book_id: record_book_id })
  scope :for_team,        (->(team_id)        { where team_id: team_id })
  scope :for_user,        (->(user_id)        { where user_id: user_id })

  def total_points
    completions.sum :points
  end

  private

  def set_membership_type
    self.membership_type = user&.membership_type
  end
end
