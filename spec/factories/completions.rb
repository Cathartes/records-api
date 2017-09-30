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

FactoryGirl.define do
  factory :completion do
    challenge

    rank   { Faker::Number.between 1, 100 }
    points { Faker::Number.between 1, 100 }

    trait(:applicant) { association :participation, :applicant }
    trait(:member)    { association :participation, :member }

    trait(:approved) { status :approved }
    trait(:declined) { status :declined }
  end
end
