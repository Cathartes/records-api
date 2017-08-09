require 'rails_helper'
require 'pundit/matchers'

RSpec.describe TeamPolicy, type: :policy do
  subject { described_class.new user, record_book }

  let(:record_book) { Team.new }

  context 'when logged out' do
    let(:user) { nil }

    it { is_expected.to forbid_action :create }
    it { is_expected.to forbid_action :destroy }
    it { is_expected.to permit_action :index }
    it { is_expected.to permit_action :show }
    it { is_expected.to forbid_action :update }
  end

  context 'when logged in' do
    context 'when the User is an admin' do
      let(:user) { User.new admin: true }

      it { is_expected.to permit_action :create }
      it { is_expected.to permit_action :destroy }
      it { is_expected.to permit_action :index }
      it { is_expected.to permit_action :show }
      it { is_expected.to permit_action :update }
    end
  end
end
