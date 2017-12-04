require 'rails_helper'
require 'pundit/matchers'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class.new user, other_user }

  let(:other_user) { User.new }

  context 'when logged out' do
    let(:user) { nil }

    it { is_expected.to forbid_action :create }
    it { is_expected.to forbid_action :destroy }
    it { is_expected.to permit_action :index }
    it { is_expected.to forbid_action :update }
  end

  context 'when logged in' do
    context 'when the User does not own the other user' do
      let(:user) { User.new }

      it { is_expected.to forbid_action :create }
      it { is_expected.to forbid_action :destroy }
      it { is_expected.to permit_action :index }
      it { is_expected.to forbid_action :update }
    end

    context 'when the User owns the other user' do
      let(:user) { other_user }

      it { is_expected.to forbid_action :create }
      it { is_expected.to forbid_action :destroy }
      it { is_expected.to permit_action :index }
      it { is_expected.to permit_action :update }
    end

    context 'when the User is an admin' do
      let(:user) { User.new admin: true }

      it { is_expected.to permit_action :create }
      it { is_expected.to permit_action :destroy }
      it { is_expected.to permit_action :index }
      it { is_expected.to permit_action :update }
    end
  end
end
