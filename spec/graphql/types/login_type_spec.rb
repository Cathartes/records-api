# frozen_string_literal: true

require 'rails_helper'
require 'rspec/graphql_matchers'

RSpec.describe Types::LoginType do
  it { is_expected.to have_field(:token).of_type 'String' }
  it { is_expected.to have_field(:uid).of_type 'String' }
  it { is_expected.to have_field(:user).of_type 'User' }
end
