# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::List::Users do
  describe '.call' do
    let!(:applicant_user) { create :user, :applicant }
    let!(:member_user)    { create :user, :member }
    let!(:retired_user)   { create :user, :retired }

    let(:users) { described_class.new.call({}, args, pundit: GraphqlController.new) }

    context 'when no args are passed' do
      let(:args) { {} }

      it 'returns all users' do
        expect(users).to eq [applicant_user, member_user, retired_user]
      end
    end

    context 'when membership_type is applicant' do
      let(:args) { { membership_type: 'applicant' } }

      it 'returns applicant users' do
        expect(users).to eq [applicant_user]
      end
    end

    context 'when membership_type is member' do
      let(:args) { { membership_type: 'member' } }

      it 'returns member users' do
        expect(users).to eq [member_user]
      end
    end

    context 'when membership_type is retired' do
      let(:args) { { membership_type: 'retired' } }

      it 'returns retired users' do
        expect(users).to eq [retired_user]
      end
    end
  end
end
