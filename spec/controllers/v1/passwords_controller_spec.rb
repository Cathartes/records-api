require 'rails_helper'

require 'support/controllers/auth_helpers'
require 'support/controllers/response_helpers'

RSpec.describe V1::PasswordsController, type: :controller do
  describe 'POST #create' do
    before(:each) { post :create, params: { data: data } }

    context 'when the User is not found' do
      let(:data) { { attributes: { email: '' } } }
      it { is_expected.to respond_with 404 }
    end

    context 'when the User is found' do
      let(:user) { create :user, :claimed }
      let(:data) { { attributes: { email: user.email, reset_password_redirect_url: 'fake' } } }

      include_examples 'no content'

      it 'generates a reset password token for the User' do
        expect(user.reload.reset_password_token).to be_present
      end
    end
  end

  describe 'PATCH #update' do
    before(:each) { patch :update, params: { data: data } }

    context 'when the User is not found' do
      let(:data)    { { attributes: { reset_password_token: '' } } }
      it            { is_expected.to respond_with 404 }
    end

    context 'when the User is found' do
      let!(:user) { create :user, :claimed, reset_password_token: SecureRandom.urlsafe_base64(nil, false) }

      context 'when the User fails to save' do
        let(:data) { { attributes: { password: 'fake', reset_password_token: user.reset_password_token } } }
        include_examples 'unprocessable entity'
      end

      context 'when the User successfully saves' do
        let(:data) do
          {
            attributes: {
              password: Faker::Internet.password(6, 72),
              reset_password_token: user.reset_password_token
            }
          }
        end

        include_examples 'ok'

        it 'is expected to set the reset password token to nil' do
          expect(user.reload.reset_password_token).to be nil
        end

        it 'is expected to return auth headers' do
          expect(response.headers['X-USER-UID']).to eq user.email
          expect(response.headers['X-USER-TOKEN']).to be_present
        end

        it 'is expected to return the User' do
          json = extract_response
          expect(json['data']['id']).to eq user.id.to_s
        end
      end
    end
  end
end
