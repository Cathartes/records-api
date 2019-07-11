# frozen_string_literal: true

require 'rails_helper'
require 'rspec/graphql_matchers'

RSpec.describe Types::UserType do
  it { is_expected.to have_field(:email).of_type 'String' }
  it { is_expected.to have_field(:discordName).of_type 'String!' }
  it { is_expected.to have_field(:resetPasswordSentAt).of_type 'String' }
  it { is_expected.to have_field(:confirmedAt).of_type 'String' }
  it { is_expected.to have_field(:confirmationSentAt).of_type 'String' }
  it { is_expected.to have_field(:unconfirmedEmail).of_type 'String' }
  it { is_expected.to have_field(:admin).of_type 'Boolean!' }
  it { is_expected.to have_field(:passwordUpdatedAt).of_type 'String' }
  it { is_expected.to have_field(:membershipType).of_type 'UserMembershipType!' }

  it { is_expected.to have_field(:participations).of_type '[Participation]!' }
end
