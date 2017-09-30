require 'rails_helper'
require 'pundit/matchers'

RSpec.describe MomentPolicy, type: :policy do
  subject { described_class.new user, moment }

  let(:moment) { Moment.new }

  context 'when logged out' do
    let(:user) { nil }

    it { is_expected.to permit_action :index }
  end

  context 'when logged in' do
    let(:user) { User.new }

    it { is_expected.to permit_action :index }

    context 'when the User is an admin' do
      let(:user) { User.new admin: true }

      it { is_expected.to permit_action :index }
    end
  end
end
