require 'rails_helper'

require 'support/controllers/auth_helpers'
require 'support/controllers/response_helpers'

RSpec.describe V1::SessionsController, type: :controller do
  describe 'POST #create' do
    before(:each) { post :create, params: { data: data } }

    context 'when the login fails' do
      let(:data) { { attributes: { email: '' } } }
      it { is_expected.to respond_with 401 }
    end

    context 'when the login is successful' do
      let(:user) { create :user, :claimed }
      let(:data) { { attributes: { email: user.email, password: user.password } } }

      include_examples 'ok'

      it 'is expected to return auth headers' do
        expect(response.headers['X-USER-EMAIL']).to eq user.email
        expect(response.headers['X-USER-TOKEN']).to be_present
      end

      it 'is expected to return the User' do
        json = extract_response
        expect(json['data']['id']).to eq user.id.to_s
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:token) { create :authentication_token }

    before(:each) do
      authenticate_user token.user
      delete :destroy
    end

    include_examples 'no content'

    it 'is expected to destroy the current Authentication Token' do
      expect(AuthenticationToken.count).to eq 0
    end
  end

  describe 'GET #show' do
    include_examples 'authentication required', :get, :show

    context 'when the User is logged in' do
      let(:user) { create :user, :claimed }

      before(:each) do
        authenticate_user user
        get :show
      end

      include_examples 'ok'

      it 'is expected to return the current User' do
        json = extract_response
        expect(json['data']['type']).to eq 'users'
        expect(json['data']['id']).to eq user.id.to_s
      end
    end
  end
end
