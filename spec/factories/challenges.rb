FactoryGirl.define do
  factory :challenge do
    record_book
    name { Faker::Name.first_name }
    points { { 0 => 1 } }

    trait(:applicants) { challenge_type :applicants }
    trait(:everyone)   { challenge_type :everyone }
    trait(:members)    { challenge_type :members }
    trait(:published)  { association :record_book, :published }
  end
end
