# frozen_string_literal: true

# == Schema Information
#
# Table name: challenges
#
#  id                :integer          not null, primary key
#  record_book_id    :integer          not null
#  name              :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  points_completion :integer          not null
#  points_first      :integer
#  points_second     :integer
#  points_third      :integer
#  completions_count :integer          default(0), not null
#  position          :integer          not null
#  challenge_type    :integer          not null
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

  describe 'enums' do
    it { is_expected.to define_enum_for(:challenge_type).with %i[everyone applicant member] }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :challenge_type }
    it { is_expected.to validate_presence_of :record_book }
    it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most 24 }
    it { is_expected.to validate_numericality_of(:points_completion).is_greater_than_or_equal_to(0).only_integer }
  end

  describe '.points_for_rank' do
    let(:challenge) { Challenge.new points_completion: 20, points_first: 50 }

    context 'when "rank" does not exist' do
      it 'returns points for rank 0' do
        expect(challenge.points_for_rank(2)).to eq 20
      end
    end

    context 'when "rank" exists' do
      it 'returns the correct points' do
        expect(challenge.points_for_rank(1)).to eq 50
      end
    end
  end
end
