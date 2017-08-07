require 'rails_helper'
require 'pundit/matchers'

RSpec.describe ParticipationPolicy, type: :policy do
  subject { described_class.new user, participation }

  let(:participation) { Participation.new }

  context 'when logged out' do
    let(:user) { nil }

    it { is_expected.to forbid_action :create }
    it { is_expected.to forbid_action :destroy }
    it { is_expected.to permit_action :index }
    it { is_expected.to forbid_action :show }
    it { is_expected.to forbid_action :update }

    context 'when the Record Book is published' do
      let(:participation) { Participation.new record_book: RecordBook.new(published: true) }

      it { is_expected.to permit_action :show }
    end
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