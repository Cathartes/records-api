require 'rails_helper'

RSpec.describe RecordBook, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:challenges).dependent :destroy }
  end

  describe 'validations' do
    it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most 24 }
  end
end
