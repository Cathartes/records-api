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
        include_examples 'forbidden'
      end

      context 'when the User has permission' do
        let(:user) { create :user, :admin }

        context 'when the User fails to save' do
          let(:data) { { attributes: { discord_name: '' } } }
          include_examples 'unprocessable entity'
        end

        context 'when the User successfully saves' do
          let(:data) { { attributes: { discord_name: Faker::Name.name } } }

          include_examples 'created'

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
    include_examples 'authentication required', :patch, :update, params: { id: -1 }

    context 'when the User is logged in' do
      let(:user)    { create :user, :claimed }
      before(:each) { authenticate_user user }

      include_examples 'not found', :patch, :update, model: 'User'

      context 'when the User is found' do
        let(:other_user) { create :user }
        before(:each)    { patch :update, params: { id: other_user.id, data: data } }

        context 'when the User does not have permission' do
          let(:data) { nil }
          include_examples 'forbidden'
        end

        context 'when the User has permission' do
          let(:user) { create :user, :admin }

          context 'when the User fails to save' do
            let(:data) { { attributes: { discord_name: '' } } }

            include_examples 'unprocessable entity'

            it 'is expected to not update the User' do
              original_name = other_user.discord_name
              expect(other_user.reload.discord_name).to eq original_name
            end
          end

          context 'when the User successfully saves' do
            let(:data) { { attributes: { discord_name: other_user.discord_name.first(72) + ' New' } } }

            include_examples 'ok'

            it 'is expected to update the User' do
              expect(other_user.reload.discord_name).to eq data[:attributes][:discord_name]
            end

            it 'is expected to return the User' do
              json = extract_response
              expect(json['data']['type']).to eq 'users'
              expect(json['data']['id']).to eq other_user.id.to_s
              expect(json['data']['attributes']['discord_name']).to eq data[:attributes][:discord_name]
            end
          end
        end
      end
    end
  end
end
