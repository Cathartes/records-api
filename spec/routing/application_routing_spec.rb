# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Application Routing', type: :routing do
  it 'routes GET "/" to ApplicationController' do
    expect(get('/')).to route_to 'application#index'
  end
end
