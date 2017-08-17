require 'rails_helper'

RSpec.describe Challenge, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :record_book }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :points }
    it { is_expected.to validate_presence_of :record_book }
    it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most 24 }
    it do
      is_expected.to validate_numericality_of(:max_completions)
        .is_greater_than_or_equal_to(0).is_less_than_or_equal_to(100).only_integer
    end
  end
end
