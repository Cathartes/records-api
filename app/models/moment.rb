# == Schema Information
#
# Table name: moments
#
#  id             :integer          not null, primary key
#  record_book_id :integer          not null
#  trackable_type :string           not null
#  trackable_id   :integer          not null
#  moment_type    :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_moments_on_record_book_id                   (record_book_id)
#  index_moments_on_trackable_type_and_trackable_id  (trackable_type,trackable_id)
#

class Moment < ApplicationRecord
  belongs_to :record_book
  belongs_to :trackable, polymorphic: true

  belongs_to :completion, foreign_key: :trackable_id, foreign_type: 'Completion', optional: true
  belongs_to :user, foreign_key: :trackable_id, foreign_type: 'User', optional: true

  enum moment_type: { new_member: 0, completion: 1 }

  validates :moment_type, :record_book, :trackable, presence: true
  validates :trackable_type, inclusion: %w[Completion User]

  scope :for_record_book, (->(record_book_id) { where record_book_id: record_book_id })
  scope :for_user, (lambda do |user_id|
    joins('LEFT JOIN completions ON completions.id = moments.trackable_id')
      .joins('LEFT JOIN participations ON participations.id = completions.participation_id')
      .where 'moment_type = :new_member OR moment_type = :completion AND participations.user_id = :user_id',
             new_member: moment_types[:new_member], completion: moment_types[:completion], user_id: user_id
  end)

  def participation
    if new_member?
      Participation.find_by record_book_id: record_book_id, user_id: trackable_id
    elsif completion?
      Participation.joins(:completions).find_by completions: { id: trackable_id }
    end
  end
end
