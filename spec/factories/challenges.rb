FactoryGirl.define do
  factory :challenge do
    record_book
    name { Faker::Name.first_name }
    max_completions { Faker::Number.between 0, 10 }
    points { { 0 => 1 } }

    trait(:published) { association :record_book, :published }
  end
end
