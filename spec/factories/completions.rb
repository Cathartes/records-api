FactoryGirl.define do
  factory :completion do
    challenge

    rank   { Faker::Number.between 1, 100 }
    points { Faker::Number.between 1, 100 }

    trait(:applicant) { association :participation, :applicant }
    trait(:member)    { association :participation, :member }
  end
end
