require 'rails_helper'

require 'support/controllers/auth_helpers'
require 'support/controllers/response_helpers'

RSpec.describe V1::TeamsController, type: :controller do
  describe 'POST #create' do
    include_examples 'authentication required', :post, :create

    context 'when the User is logged in' do
      before(:each) do
        authenticate_user user
        post :create, params: { data: data }
      end

      context 'when the User does not have permission' do
        let(:user) { create :user, :claimed }
        let(:data) { { attributes: { name: '' } } }
        include_examples 'forbidden'
      end

      context 'when the User has permission' do
        let(:user) { create :user, :admin }

        context 'when the Team fails to save' do
          let(:data) { { attributes: { name: '' } } }
          include_examples 'unprocessable entity'
        end

        context 'when the Team successfully saves' do
          let(:data) { { attributes: { name: Faker::Name.first_name } } }

          include_examples 'created'

          it 'is expected to create the Team' do
            expect(Team.count).to eq 1
          end

          it 'is expected to return the Team' do
            json = extract_response
            expect(json['data']['type']).to eq 'teams'
            expect(json['data']['attributes']['name']).to eq data[:attributes][:name]
          end
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    include_examples 'authentication required', :delete, :destroy, params: { id: -1 }

    context 'when the User is logged in' do
      let(:user)    { create :user, :claimed }
      before(:each) { authenticate_user user }

      include_examples 'not found', :delete, :destroy, model: 'Team'

      context 'when the Team is found' do
        let(:team)    { create :team }
        before(:each) { delete :destroy, params: { id: team.id } }

        context 'when the User does not have permission' do
          include_examples 'forbidden'
        end

        context 'when the User has permission' do
          let(:user) { create :user, :admin }

          include_examples 'no content'

          it 'is expected to destroy the Team' do
            expect(Team.count).to eq 0
          end
        end
      end
    end
  end

  describe 'GET #index' do
    let!(:team) { create :team }

    context 'when no params are passed' do
      before(:each) { get :index }

      include_examples 'ok'

      it 'is expected to return all Teams' do
        json = extract_response
        expect(json['data'].length).to eq 1
        json['data'].each do |team|
          expect(team['type']).to eq 'teams'
        end
      end
    end
  end

  describe 'GET #show' do
    include_examples 'not found', :get, :show, model: 'Team'

    context 'when the Team is found' do
      let(:team)    { create :team }
      before(:each) { get :show, params: { id: team.id } }

      include_examples 'ok'

      it 'is expected to return the Team' do
        json = extract_response
        expect(json['data']['type']).to eq 'teams'
        expect(json['data']['id']).to eq team.id.to_s
      end
    end
  end

  describe 'PATCH #update' do
    include_examples 'authentication required', :patch, :update, params: { id: -1 }

    context 'when the User is logged in' do
      let(:user)    { create :user, :claimed }
      before(:each) { authenticate_user user }

      include_examples 'not found', :patch, :update, model: 'Team'

      context 'when the Team is found' do
        let(:team)    { create :team }
        before(:each) { patch :update, params: { id: team.id, data: data } }

        context 'when the User does not have permission' do
          let(:data) { nil }
          it         { is_expected.to respond_with 403 }
        end

        context 'when the User has permission' do
          let(:user) { create :user, :admin }

          context 'when the Team fails to save' do
            let(:data) { { attributes: { name: '' } } }

            include_examples 'unprocessable entity'

            it 'is expected to not update the Team' do
              original_name = team.name
              expect(team.reload.name).to eq original_name
            end
          end

          context 'when the Team successfully saves' do
            let(:data) { { attributes: { name: team.name.first(20) + ' New' } } }

            include_examples 'ok'

            it 'is expected to update the Team' do
              expect(team.reload.name).to eq data[:attributes][:name]
            end

            it 'is expected to return the Team' do
              json = extract_response
              expect(json['data']['type']).to eq 'teams'
              expect(json['data']['id']).to eq team.id.to_s
              expect(json['data']['attributes']['name']).to eq data[:attributes][:name]
            end
          end
        end
      end
    end
  end
end
