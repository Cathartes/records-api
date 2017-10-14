require 'rails_helper'

RSpec.describe 'Graphql Routing', type: :routing do
  it 'routes POST "/graphql" to GraphqlController' do
    expect(post('/graphql')).to route_to 'graphql#execute'
  end
end
