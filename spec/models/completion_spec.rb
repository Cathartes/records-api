require 'rails_helper'

RSpec.describe Completion, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :challenge }
    it { is_expected.to belong_to :participation }
    it { is_expected.to have_one :user }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :challenge }
    it { is_expected.to validate_presence_of :participation }
    it { is_expected.to validate_numericality_of(:rank).is_greater_than(0).is_less_than_or_equal_to(100).only_integer }
    it do
      is_expected.to validate_numericality_of(:points).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(100).only_integer
    end
  end
end
