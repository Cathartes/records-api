# frozen_string_literal: true

FactoryBot.define do
  factory :authentication_token do
    association :user, :claimed
  end
end
