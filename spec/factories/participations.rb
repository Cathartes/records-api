# == Schema Information
#
# Table name: participations
#
#  id             :integer          not null, primary key
#  record_book_id :integer          not null
#  team_id        :integer
#  user_id        :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_participations_on_record_book_id  (record_book_id)
#  index_participations_on_team_id         (team_id)
#  index_participations_on_user_id         (user_id)
#

FactoryGirl.define do
  factory :participation do
    record_book
    team
    user

    trait(:published) { association :record_book, :published }
  end
end
