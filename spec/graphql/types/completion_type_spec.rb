# frozen_string_literal: true

require 'rails_helper'
require 'rspec/graphql_matchers'

RSpec.describe Types::CompletionType do
  it { is_expected.to have_field(:challengeId).of_type 'Int!' }
  it { is_expected.to have_field(:participationId).of_type 'Int!' }
  it { is_expected.to have_field(:points).of_type 'Int!' }
  it { is_expected.to have_field(:rank).of_type 'Int!' }
  it { is_expected.to have_field(:status).of_type 'CompletionStatus!' }

  it { is_expected.to have_field(:challenge).of_type 'Challenge!' }
  it { is_expected.to have_field(:participation).of_type 'Participation!' }

  it { is_expected.to have_field(:recordBook).of_type 'RecordBook!' }
  it { is_expected.to have_field(:user).of_type 'User!' }
end
