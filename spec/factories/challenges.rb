# == Schema Information
#
# Table name: challenges
#
#  id              :integer          not null, primary key
#  record_book_id  :integer          not null
#  name            :string           not null
#  points          :jsonb            not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  max_completions :integer          not null
#
# Indexes
#
#  index_challenges_on_record_book_id  (record_book_id)
#

FactoryGirl.define do
  factory :challenge do
    record_book
    name { Faker::Name.first_name }
    max_completions { Faker::Number.between 0, 10 }
    points { { 0 => 1 } }

    trait(:published) { association :record_book, :published }
  end
end
