require 'rails_helper'

RSpec.describe 'V1 Passwords Routing', type: :routing do
  it 'routes POST "/v1/passwords" to PasswordsController' do
    expect(post('/v1/passwords')).to route_to 'v1/passwords#create', format: :json
  end

  it 'routes PATCH "/v1/passwords" to PasswordsController' do
    expect(patch('/v1/passwords')).to route_to 'v1/passwords#update', format: :json
  end
end
