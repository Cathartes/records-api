# == Schema Information
#
# Table name: record_books
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  published       :boolean          default(FALSE), not null
#  start_time      :datetime
#  end_time        :datetime
#  rush_start_time :datetime
#  rush_end_time   :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe RecordBook, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:challenges).dependent :destroy }
    it { is_expected.to have_many(:participations).dependent :destroy }
    it { is_expected.to have_many :teams }
  end

  describe 'validations' do
    it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most 24 }
  end
end
