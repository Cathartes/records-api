require 'rails_helper'

RSpec.describe 'V1 Users Routing', type: :routing do
  it 'routes POST "/v1/users" to UsersController' do
    expect(post('/v1/users')).to route_to 'v1/users#create', format: 'json'
  end

  it 'routes PATCH "/v1/users/:id" to UsersController' do
    expect(patch('/v1/users/1')).to route_to 'v1/users#update', format: 'json', id: '1'
  end
end
