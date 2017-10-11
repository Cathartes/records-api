# == Schema Information
#
# Table name: moments
#
#  id             :integer          not null, primary key
#  record_book_id :integer          not null
#  trackable_type :string           not null
#  trackable_id   :integer          not null
#  moment_type    :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_moments_on_record_book_id                   (record_book_id)
#  index_moments_on_trackable_type_and_trackable_id  (trackable_type,trackable_id)
#

require 'rails_helper'

RSpec.describe Moment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :record_book }
    it { is_expected.to belong_to :trackable }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :moment_type }
    it { is_expected.to validate_presence_of :record_book }
    it { is_expected.to validate_presence_of :trackable }
    it { is_expected.to validate_inclusion_of(:trackable_type).in_array %w[Completion User] }
  end

  describe 'enums' do
    it { should define_enum_for(:moment_type).with %i[new_member completion] }
  end
end
