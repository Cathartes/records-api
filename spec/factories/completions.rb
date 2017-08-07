FactoryGirl.define do
  factory :completion do
    rank { Faker::Number.between 1, 100 }

    trait(:applicant) do
      association :challenge, :applicant
      association :participation, :applicant
    end
    trait(:member) do
      association :challenge, :member
      association :participation, :member
    end
  end
end
