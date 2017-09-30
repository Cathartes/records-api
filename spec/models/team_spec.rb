# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:participations).dependent :destroy }
  end

  describe 'validations' do
    it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most 24 }
  end

  describe '.total_points_for_record_book' do
    let(:team)          { create :team }
    let(:participation) { create :participation, team: team }
    let!(:completion)   { create :completion, participation: participation }

    it 'is expected to return the total points the Team has' do
      expect(team.total_points_for_record_book(participation.record_book)).to eq completion.points
    end
  end
end
