module ResponseHelpers
  def extract_response(with_data: true)
    expect(response.body).to_not be_empty
    json = JSON.parse response.body
    expect(json['data']).to be_present if with_data
    json
  end
end

RSpec.configure do |c|
  c.include ResponseHelpers
end

RSpec.shared_examples 'authentication required' do |http_method, action_name, params: {}|
  context 'when the User is not logged in' do
    before(:each) { method(http_method).call action_name, params: params }
    it            { is_expected.to respond_with 401 }
  end
end

RSpec.shared_examples 'created' do
  it { is_expected.to respond_with 201 }
end

RSpec.shared_examples 'no content' do
  it { is_expected.to respond_with 204 }
end

RSpec.shared_examples 'not found' do |http_method, action_name, model: 'Model'|
  context "when the #{model} is not found" do
    before(:each) { method(http_method).call action_name, params: { id: -1 } }
    it            { is_expected.to respond_with 404 }
  end
end

RSpec.shared_examples 'ok' do
  it { is_expected.to respond_with 200 }
end

RSpec.shared_examples 'unprocessable entity' do
  it 'is expected to return errors' do
    json = extract_response with_data: false
    expect(json['errors']).to_not be_empty
  end

  it { is_expected.to respond_with 422 }
end
