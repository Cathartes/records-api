# == Schema Information
#
# Table name: moments
#
#  id             :integer          not null, primary key
#  record_book_id :integer          not null
#  trackable_type :string           not null
#  trackable_id   :integer          not null
#  moment_type    :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_moments_on_record_book_id                   (record_book_id)
#  index_moments_on_trackable_type_and_trackable_id  (trackable_type,trackable_id)
#

FactoryGirl.define do
  factory :moment do
    record_book

    trait(:for_new_member) do
      association :trackable, factory: :user
      moment_type :new_member
    end

    trait(:for_completion) do
      association :trackable, factory: %i[completion member]
      moment_type :completion
    end
  end
end
