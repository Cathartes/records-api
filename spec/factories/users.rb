# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string
#  discord_name           :string           not null
#  password_digest        :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  admin                  :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  password_updated_at    :datetime
#  membership_type        :integer          default("applicant"), not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_discord_name          (discord_name) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

FactoryBot.define do
  factory :user do
    discord_name { Faker::Name.name }
    password     { Faker::Internet.password 6, 72 }

    trait(:admin) do
      claimed
      admin true
    end

    trait(:claimed) { email { Faker::Internet.email } }

    trait(:member) { membership_type :member }
  end
end
