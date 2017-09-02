# == Schema Information
#
# Table name: authentication_tokens
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  body       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_authentication_tokens_on_user_id  (user_id)
#

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
