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
