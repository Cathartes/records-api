# == Schema Information
#
# Table name: challenges
#
#  id              :integer          not null, primary key
#  record_book_id  :integer          not null
#  name            :string           not null
#  points          :jsonb            not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  max_completions :integer          not null
#
# Indexes
#
#  index_challenges_on_record_book_id  (record_book_id)
#

require 'rails_helper'

RSpec.describe Challenge, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :record_book }
    it { is_expected.to have_many(:completions).dependent :destroy }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :points }
    it { is_expected.to validate_presence_of :record_book }
    it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most 24 }
    it do
      is_expected.to validate_numericality_of(:max_completions)
        .is_greater_than_or_equal_to(0).is_less_than_or_equal_to(100).only_integer
    end
  end

  describe '.points_for_rank' do
    let(:challenge) { Challenge.new points: { 0 => 20, 1 => 50 } }

    context 'when "rank" does not exist' do
      it 'should return points for rank 0' do
        expect(challenge.points_for_rank(2)).to eq 20
      end
    end

    context 'when "rank" exists' do
      it 'should return the correct points' do
        expect(challenge.points_for_rank(1)).to eq 50
      end
    end
  end
end
