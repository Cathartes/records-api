# frozen_string_literal: true

require 'rails_helper'
require 'rspec/graphql_matchers'

RSpec.describe Types::ParticipationType do
  it { is_expected.to have_field(:membershipType).of_type 'UserMembershipType!' }
  it { is_expected.to have_field(:teamId).of_type 'Int' }

  it { is_expected.to have_field(:recordBook).of_type 'RecordBook!' }
  it { is_expected.to have_field(:team).of_type 'Team' }
  it { is_expected.to have_field(:user).of_type 'User!' }

  it { is_expected.to have_field(:completions).of_type '[Completion]!' }
end
