require 'rails_helper'

RSpec.describe 'V1 Sessions Routing', type: :routing do
  it 'routes POST "/v1/login" to SessionsController' do
    expect(post('/v1/login')).to route_to 'v1/sessions#create', format: 'json'
  end

  it 'routes DELETE "/v1/logout" to SessionsController' do
    expect(delete('/v1/logout')).to route_to 'v1/sessions#destroy', format: 'json'
  end
end
