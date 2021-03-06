# frozen_string_literal: true

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

FactoryBot.define do
  factory :challenge do
    record_book
    challenge_type    :everyone
    name              { Faker::Name.first_name }
    points_completion { Faker::Number.between 0, 50 }

    trait(:published) { association :record_book, :published }
  end
end
