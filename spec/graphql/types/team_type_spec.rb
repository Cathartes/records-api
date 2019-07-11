# frozen_string_literal: true

require 'rails_helper'
require 'rspec/graphql_matchers'

RSpec.describe Types::TeamType do
  it { is_expected.to have_field(:name).of_type 'String!' }

  it { is_expected.to have_field(:participations).of_type '[Participation]!' }
end
