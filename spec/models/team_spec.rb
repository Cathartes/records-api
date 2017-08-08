require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'validations' do
    it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most 24 }
  end
end
