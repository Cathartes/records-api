require 'rails_helper'

RSpec.describe 'V1 Teams Routing', type: :routing do
  it 'routes POST "/v1/teams" to TeamsController' do
    expect(post('/v1/teams')).to route_to 'v1/teams#create', format: :json
  end

  it 'routes DELETE "/v1/teams/:id" to TeamsController' do
    expect(delete('/v1/teams/1')).to route_to 'v1/teams#destroy', format: :json, id: '1'
  end

  it 'routes GET "/v1/teams" to TeamsController' do
    expect(get('/v1/teams')).to route_to 'v1/teams#index', format: :json
  end

  it 'routes GET "/v1/teams/:id" to TeamsController' do
    expect(get('/v1/teams/1')).to route_to 'v1/teams#show', format: :json, id: '1'
  end

  it 'routes PATCH "/v1/teams/:id" to TeamsController' do
    expect(patch('/v1/teams/1')).to route_to 'v1/teams#update', format: :json, id: '1'
  end
end
