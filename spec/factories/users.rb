FactoryGirl.define do
  factory :user do
    discord_name { Faker::Name.name }
    password     { Faker::Internet.password 6, 72 }

    trait(:admin) do
      claimed
      admin true
    end

    trait(:claimed) { email { Faker::Internet.email } }
  end
end
