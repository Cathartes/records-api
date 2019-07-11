# frozen_string_literal: true

require 'rails_helper'
require 'rspec/graphql_matchers'

RSpec.describe Types::ChallengeType do
  it { is_expected.to have_field(:name).of_type 'String!' }
  it { is_expected.to have_field(:challengeType).of_type 'ChallengeType!' }
  it { is_expected.to have_field(:pointsCompletion).of_type 'Int!' }
  it { is_expected.to have_field(:pointsFirst).of_type 'Int' }
  it { is_expected.to have_field(:pointsSecond).of_type 'Int' }
  it { is_expected.to have_field(:pointsThird).of_type 'Int' }
  it { is_expected.to have_field(:position).of_type 'Int!' }

  it { is_expected.to have_field(:recordBook).of_type 'RecordBook!' }

  it { is_expected.to have_field(:completions).of_type '[Completion]!' }

  it { is_expected.to have_field(:completionsCount).of_type 'Int!' }
end
