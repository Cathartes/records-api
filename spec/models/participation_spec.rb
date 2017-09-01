require 'rails_helper'

RSpec.describe Participation, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :record_book }
    it { is_expected.to belong_to :team }
    it { is_expected.to belong_to :user }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :record_book }
    it { is_expected.to validate_presence_of :team }
    it { is_expected.to validate_presence_of :user }
  end

  describe '.total_points' do
    let(:completion) { create :completion, :member }

    it 'is expected to return the total points the participant has' do
      expect(completion.participation.total_points).to eq completion.points
    end
  end
end
