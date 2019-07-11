# frozen_string_literal: true

require 'rails_helper'
require 'rspec/graphql_matchers'

RSpec.describe Types::QueryType do
  it { is_expected.to have_field(:challenge).of_type 'Challenge' }
  it { is_expected.to have_field(:challenges).of_type '[Challenge]!' }

  it { is_expected.to have_field(:completion).of_type 'Completion' }
  it { is_expected.to have_field(:completions).of_type '[Completion]!' }

  it { is_expected.to have_field(:currentUser).of_type 'User' }

  it { is_expected.to have_field(:participation).of_type 'Participation' }
  it { is_expected.to have_field(:participations).of_type '[Participation]!' }

  it { is_expected.to have_field(:recordBook).of_type 'RecordBook' }
  it { is_expected.to have_field(:recordBooks).of_type '[RecordBook]!' }

  it { is_expected.to have_field(:team).of_type 'Team' }
  it { is_expected.to have_field(:teams).of_type '[Team]!' }

  it { is_expected.to have_field(:user).of_type 'User' }
  it { is_expected.to have_field(:users).of_type '[User]!' }
end
