# == Schema Information
#
# Table name: completions
#
#  id               :integer          not null, primary key
#  challenge_id     :integer          not null
#  participation_id :integer          not null
#  rank             :integer          not null
#  points           :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  status           :integer          default("pending"), not null
#
# Indexes
#
#  index_completions_on_challenge_id      (challenge_id)
#  index_completions_on_participation_id  (participation_id)
#

require 'rails_helper'

RSpec.describe Completion, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :challenge }
    it { is_expected.to belong_to :participation }
    it { is_expected.to have_one :user }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with %i[pending approved declined] }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :challenge }
    it { is_expected.to validate_presence_of :participation }
    it { is_expected.to validate_presence_of :status }
    it { is_expected.to validate_numericality_of(:rank).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(3).only_integer }
    it { is_expected.to validate_numericality_of(:points).is_greater_than_or_equal_to(0).only_integer }
  end
end
