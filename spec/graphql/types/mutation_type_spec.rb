# frozen_string_literal: true

require 'rails_helper'
require 'rspec/graphql_matchers'

RSpec.describe Types::MutationType do
  it { is_expected.to have_field(:createChallenge).of_type 'Challenge' }
  it { is_expected.to have_field(:createCompletion).of_type 'Completion' }
  it { is_expected.to have_field(:createParticipation).of_type 'Participation' }
  it { is_expected.to have_field(:createRecordBook).of_type 'RecordBook' }
  it { is_expected.to have_field(:createUser).of_type 'User' }

  it { is_expected.to have_field(:login).of_type 'Login' }

  it { is_expected.to have_field(:updateChallenge).of_type 'Challenge' }
  it { is_expected.to have_field(:updateCompletion).of_type 'Completion' }
  it { is_expected.to have_field(:updateParticipation).of_type 'Participation' }
  it { is_expected.to have_field(:updateRecordBook).of_type 'RecordBook' }
  it { is_expected.to have_field(:updateUser).of_type 'User' }

  it { is_expected.to have_field(:destroyUser).of_type 'User' }
end
