FactoryGirl.define do
  factory :challenge do
    record_book
    name { Faker::Name.first_name }
    points { { 0 => 1 } }

    trait(:applicant) { challenge_type :applicant }
    trait(:everyone)  { challenge_type :everyone }
    trait(:member)    { challenge_type :member }
    trait(:published) { association :record_book, :published }
  end
end
