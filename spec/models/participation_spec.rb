# frozen_string_literal: true

# == Schema Information
#
# Table name: participations
#
#  id              :integer          not null, primary key
#  record_book_id  :integer          not null
#  team_id         :integer
#  user_id         :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  membership_type :integer          not null
#
# Indexes
#
#  index_participations_on_record_book_id  (record_book_id)
#  index_participations_on_team_id         (team_id)
#  index_participations_on_user_id         (user_id)
#

require 'rails_helper'

RSpec.describe Participation, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :record_book }
    it { is_expected.to belong_to :team }
    it { is_expected.to belong_to :user }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:membership_type).with %i[applicant member] }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :membership_type }
    it { is_expected.to validate_presence_of :record_book }
    it { is_expected.to validate_presence_of :user }

    context 'when uniqueness' do
      subject { build :participation }

      it { is_expected.to validate_uniqueness_of(:user_id).scoped_to :record_book_id }
    end
  end

  describe '.total_points' do
    let(:completion) { create :completion }

    it 'is expected to return the total points the participant has' do
      expect(completion.participation.total_points).to eq completion.points
    end
  end
end
