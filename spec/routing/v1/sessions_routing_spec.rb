require 'rails_helper'

RSpec.describe 'V1 Sessions Routing', type: :routing do
  it 'routes POST "/v1/sessions" to SessionsController' do
    expect(post('/v1/sessions')).to route_to 'v1/sessions#create', format: :json
  end

  it 'routes DELETE "/v1/sessions" to SessionsController' do
    expect(delete('/v1/sessions')).to route_to 'v1/sessions#destroy', format: :json
  end

  it 'routes GET "/v1/sessions" to SessionsController' do
    expect(get('/v1/sessions')).to route_to 'v1/sessions#show', format: :json
  end
end
