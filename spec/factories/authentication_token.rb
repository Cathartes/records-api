FactoryGirl.define do
  factory :authentication_token do
    association :user, :claimed
  end
end
