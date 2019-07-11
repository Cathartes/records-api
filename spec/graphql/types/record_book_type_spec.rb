# frozen_string_literal: true

require 'rails_helper'
require 'rspec/graphql_matchers'

RSpec.describe Types::RecordBookType do
  it { is_expected.to have_field(:name).of_type 'String!' }
  it { is_expected.to have_field(:published).of_type 'Boolean!' }
  it { is_expected.to have_field(:rushWeekActive).of_type 'Boolean!' }
  it { is_expected.to have_field(:startTime).of_type 'String' }
  it { is_expected.to have_field(:endTime).of_type 'String' }
  it { is_expected.to have_field(:rushStartTime).of_type 'String' }
  it { is_expected.to have_field(:rushEndTime).of_type 'String' }

  it { is_expected.to have_field(:challenges).of_type '[Challenge]!' }
  it { is_expected.to have_field(:participations).of_type '[Participation]!' }
  it { is_expected.to have_field(:teams).of_type '[Team]!' }
end
