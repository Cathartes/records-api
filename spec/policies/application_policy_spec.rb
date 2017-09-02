require 'rails_helper'
require 'pundit/matchers'

RSpec.describe ApplicationPolicy, type: :policy do
  subject { described_class.new user, record }

  let(:record) { nil }
  let(:user)   { nil }

  it { is_expected.to forbid_action :create }
  it { is_expected.to forbid_action :destroy }
  it { is_expected.to forbid_action :index }
  it { is_expected.to forbid_action :show }
  it { is_expected.to forbid_action :update }

  describe '.scope' do
    it 'raises an error' do
      expect { subject.scope }.to raise_error Pundit::NotDefinedError
    end
  end

  describe 'Scope' do
    let(:resolved_scope) { described_class::Scope.new(user, nil).resolve }

    it 'returns the correct scope' do
      expect(resolved_scope).to be nil
    end
  end
end
