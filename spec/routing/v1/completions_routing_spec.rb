require 'rails_helper'

RSpec.describe 'V1 Completions Routing', type: :routing do
  it 'routes POST "/v1/completions" to CompletionsController' do
    expect(post('/v1/completions')).to route_to 'v1/completions#create', format: :json
  end

  it 'routes DELETE "/v1/completions/:id" to CompletionsController' do
    expect(delete('/v1/completions/1')).to route_to 'v1/completions#destroy', format: :json, id: '1'
  end

  it 'routes GET "/v1/completions" to CompletionsController' do
    expect(get('/v1/completions')).to route_to 'v1/completions#index', format: :json
  end

  it 'routes PATCH "/v1/completions/:id" to CompletionsController' do
    expect(patch('/v1/completions/1')).to route_to 'v1/completions#update', format: :json, id: '1'
  end
end
