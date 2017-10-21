# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string
#  discord_name           :string           not null
#  password_digest        :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  admin                  :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  password_updated_at    :datetime
#  membership_type        :integer          default("applicant"), not null
#  current_user_status    :integer          default("active"), not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_discord_name          (discord_name) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:authentication_tokens).dependent :destroy }
    it { is_expected.to have_many(:participations).dependent :destroy }
    it { is_expected.to have_many :completions }

    it { is_expected.to have_one :active_participation }
    it { is_expected.to have_one :active_record_book }
  end

  describe 'enums' do
    it { should define_enum_for(:membership_type).with %i[applicant member retired] }
    it { should define_enum_for(:current_user_status).with %i[active archived deleted] }
  end

  describe 'validations' do
    it { is_expected.to validate_length_of(:discord_name).is_at_least(6).is_at_most 72 }
    it { is_expected.to allow_value('email@email.com').for :email }
    it { is_expected.to_not allow_value('fake').for :email }
    it { is_expected.to validate_length_of(:password).is_at_least(6).is_at_most 72 }
  end

  describe '.find_token' do
    let(:tokens) { [AuthenticationToken.new(body: '12345')] }
    let(:user)   { User.new authentication_tokens: tokens }

    context 'when the token is found' do
      it 'is expected to return the matching token' do
        expect(user.find_token(tokens.first.body)).to eq tokens.first
      end
    end

    context 'when the token is not found' do
      it 'is expected to return nil' do
        expect(user.find_token('fake')).to be nil
      end
    end
  end

  describe '.send_reset_password_instructions!' do
    let(:user) { create :user, :claimed }

    before(:each) do
      AuthMailer.expects(:reset_password_instructions).with(user, nil).returns stub deliver: true
      Timecop.freeze
      user.send_reset_password_instructions!
    end

    after(:each) { Timecop.return }

    it 'is expected to create a reset password token' do
      expect(user.reset_password_token).to be_present
    end

    it 'is expected to set reset password sent at to now' do
      expect(user.reset_password_sent_at).to eq Time.now.utc
    end
  end
end
