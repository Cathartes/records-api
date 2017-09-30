require 'rails_helper'

RSpec.describe 'V1 Moments Routing', type: :routing do
  it 'routes GET "/v1/moments" to MomentsController' do
    expect(get('/v1/moments')).to route_to 'v1/moments#index', format: :json
  end
end
