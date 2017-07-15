FactoryGirl.define do
  factory :record_book do
    name { Faker::Name.first_name }
    time_zone 'UTC'

    trait(:published) { published true }
  end
end
