require 'rails_helper'

RSpec.describe Challenge, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :record_book }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:challenge_type).with %i[member applicant everyone] }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :challenge_type }
    it { is_expected.to validate_presence_of :points }
    it { is_expected.to validate_presence_of :record_book }
    it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most 24 }
  end
end
