# == Schema Information
#
# Table name: record_books
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  published       :boolean          default(FALSE), not null
#  start_time      :datetime
#  end_time        :datetime
#  rush_start_time :datetime
#  rush_end_time   :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :record_book do
    name { Faker::Name.first_name }

    trait(:published) { published true }
  end
end
