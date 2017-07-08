require 'rails_helper'

require 'support/controllers/auth_helpers'
require 'support/controllers/response_helpers'

RSpec.describe V1::UsersController, type: :controller do
  describe 'POST #create' do
    include_examples 'authentication required', :post, :create

    context 'when the User is logged in' do
      before(:each) do
        authenticate_user user
        post :create, params: { data: data }
      end

      context 'when the User does not have permission' do
        let(:user) { create :user, :claimed }
        let(:data) { { attributes: { discord_name: '' } } }
        it         { is_expected.to respond_with 403 }
      end

      context 'when the User has permission' do
        let(:user) { create :user, :admin }

        context 'when the User fails to save' do
          let(:data) { { attributes: { discord_name: '' } } }
          include_examples 'unprocessable entity'
        end

        context 'when the User successfully saves' do
          let(:data) { { attributes: { discord_name: Faker::Name.name, password: Faker::Internet.password(8, 72) } } }

          include_examples 'ok'

          it 'is expected to create the User' do
            expect(User.count).to eq 2
          end

          it 'is expected to return the User' do
            json = extract_response
            expect(json['data']['type']).to eq 'users'
            expect(json['data']['attributes']['discord_name']).to eq data[:attributes][:discord_name]
          end
        end
      end
    end
  end

  describe 'PATCH #update' do
  end
end
