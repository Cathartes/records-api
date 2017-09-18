require 'rails_helper'

RSpec.describe 'V1 Participations Routing', type: :routing do
  it 'routes POST "/v1/participations" to ParticipationsController' do
    expect(post('/v1/participations')).to route_to 'v1/participations#create', format: :json
  end

  it 'routes DELETE "/v1/participations/:id" to ParticipationsController' do
    expect(delete('/v1/participations/1')).to route_to 'v1/participations#destroy', format: :json, id: '1'
  end

  it 'routes GET "/v1/participations" to ParticipationsController' do
    expect(get('/v1/participations')).to route_to 'v1/participations#index', format: :json
  end

  it 'routes GET "/v1/participations/:id" to ParticipationsController' do
    expect(get('/v1/participations/1')).to route_to 'v1/participations#show', format: :json, id: '1'
  end

  it 'routes PATCH "/v1/participations/:id" to ParticipationsController' do
    expect(patch('/v1/participations/1')).to route_to 'v1/participations#update', format: :json, id: '1'
  end
end
