require 'rails_helper'

RSpec.describe 'V1 Challenges Routing', type: :routing do
  it 'routes POST "/v1/challenges" to ChallengesController' do
    expect(post('/v1/challenges')).to route_to 'v1/challenges#create', format: 'json'
  end

  it 'routes DELETE "/v1/challenges/:id" to ChallengesController' do
    expect(delete('/v1/challenges/1')).to route_to 'v1/challenges#destroy', format: 'json', id: '1'
  end

  it 'routes GET "/v1/challenges" to ChallengesController' do
    expect(get('/v1/challenges')).to route_to 'v1/challenges#index', format: 'json'
  end

  it 'routes GET "/v1/challenges/:id" to ChallengesController' do
    expect(get('/v1/challenges/1')).to route_to 'v1/challenges#show', format: 'json', id: '1'
  end

  it 'routes PATCH "/v1/challenges/:id" to ChallengesController' do
    expect(patch('/v1/challenges/1')).to route_to 'v1/challenges#update', format: 'json', id: '1'
  end
end
