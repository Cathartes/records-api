FactoryGirl.define do
  factory :participation do
    record_book
    team
    user

    trait(:member)    { participation_type :member }
    trait(:applicant) { participation_type :applicant }
    trait(:published) { association :record_book, :published }
  end
end
