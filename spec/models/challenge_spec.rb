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
end
