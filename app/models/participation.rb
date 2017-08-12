class Participation < ApplicationRecord
  belongs_to :record_book
  belongs_to :team
  belongs_to :user

  enum participation_type: { member: 0, applicant: 1 }

  validates :record_book, :team, :user, :participation_type, presence: true

  scope :for_record_book, (->(record_book_id) { where record_book_id: record_book_id })
  scope :for_team,        (->(team_id)        { where team_id: team_id })
  scope :for_user,        (->(user_id)        { where user_id: user_id })
end
