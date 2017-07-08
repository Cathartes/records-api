require 'rails_helper'

RSpec.describe AuthenticationToken, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :user }
  end

  describe 'before_validation' do
    describe '.generate_token' do
      it 'is expected to generate a token' do
        authentication_token = AuthenticationToken.new
        expect { authentication_token.valid? }.to change { authentication_token.body.nil? }.from(true).to false
      end
    end
  end
end
