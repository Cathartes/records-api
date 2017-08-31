require 'rails_helper'

require 'support/controllers/auth_helpers'
require 'support/controllers/response_helpers'

RSpec.describe V1::CompletionsController, type: :controller do
  describe 'POST #create' do
    include_examples 'authentication required', :post, :create

    context 'when the User is logged in' do
      before(:each) do
        authenticate_user user
        post :create, params: { data: data }
      end

      context 'when the User does not have permission' do
        let(:user) { create :user, :claimed }
        let(:data) { { attributes: { rank: -1 } } }
        include_examples 'forbidden'
      end

      context 'when the User has permission' do
        let(:user) { create :user, :admin }

        context 'when the Completion fails to save' do
          let(:data) { { attributes: { rank: -1 } } }
          include_examples 'unprocessable entity'
        end

        context 'when the Completion successfully saves' do
          let(:challenge)     { create :challenge }
          let(:participation) { create :participation, :member }
          let(:data) do
            {
              attributes: {
                challenge_id: challenge.id,
                participation_id: participation.id,
                rank: Faker::Number.between(1, 100)
              }
            }
          end

          include_examples 'created'

          it 'is expected to create the Completion' do
            expect(Completion.count).to eq 1
          end

          it 'is expected to return the Completion' do
            json = extract_response
            expect(json['data']['type']).to eq 'completions'
            expect(json['data']['attributes']['rank']).to eq data[:attributes][:rank]
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

      include_examples 'not found', :delete, :destroy, model: 'Completion'

      context 'when the Completion is found' do
        let(:completion) { create :completion, :member }
        before(:each)    { delete :destroy, params: { id: completion.id } }

        context 'when the User does not have permission' do
          include_examples 'forbidden'
        end

        context 'when the User has permission' do
          let(:user) { create :user, :admin }

          include_examples 'no content'

          it 'is expected to destroy the Completion' do
            expect(Completion.count).to eq 0
          end
        end
      end
    end
  end

  describe 'GET #index' do
    context 'when no params are passed' do
      let(:participation)     { create :participation, :member, user: create(:user, :claimed) }
      let!(:completion)       { create :completion, :member, participation: participation }
      let!(:other_completion) { create :completion, :member }

      context 'when the User is not an admin' do
        before(:each) do
          authenticate_user completion.user
          get :index
        end

        include_examples 'ok'

        it 'is expected to return Completions for the User' do
          json = extract_response
          expect(json['data'].length).to eq 1
          json['data'].each do |completion|
            expect(completion['type']).to eq 'completions'
          end
        end
      end

      context 'when the User is an admin' do
        let(:user) { create :user, :admin }

        before(:each) do
          authenticate_user user
          get :index
        end

        include_examples 'ok'

        it 'is expected to return all Completions' do
          json = extract_response
          expect(json['data'].length).to eq 2
          json['data'].each do |completion|
            expect(completion['type']).to eq 'completions'
          end
        end
      end
    end

    context 'when "participation_id" is passed' do
      let(:user)              { create :user, :admin }
      let!(:completion)       { create :completion, :member }
      let!(:other_completion) { create :completion, :member }

      before(:each) do
        authenticate_user user
        get :index, params: { participation_id: completion.participation_id }
      end

      include_examples 'ok'

      it 'is expected to return Completions for the Participation' do
        json = extract_response
        expect(json['data'].length).to eq 1
        json['data'].each do |completion|
          expect(completion['type']).to eq 'completions'
        end
        completion_ids = json['data'].map { |completion| completion['id'] }
        expect(completion_ids).to include completion.id.to_s
      end
    end

    context 'when "user_id" is passed' do
      let(:user)              { create :user, :admin }
      let!(:completion)       { create :completion, :member }
      let!(:other_completion) { create :completion, :member }

      before(:each) do
        authenticate_user user
        get :index, params: { user_id: completion.user.id }
      end

      include_examples 'ok'

      it 'is expected to return Completions for the User' do
        json = extract_response
        expect(json['data'].length).to eq 1
        json['data'].each do |completion|
          expect(completion['type']).to eq 'completions'
        end
        completion_ids = json['data'].map { |completion| completion['id'] }
        expect(completion_ids).to include completion.id.to_s
      end
    end
  end

  describe 'PATCH #update' do
    include_examples 'authentication required', :patch, :update, params: { id: -1 }

    context 'when the User is logged in' do
      let(:user)    { create :user, :claimed }
      before(:each) { authenticate_user user }

      include_examples 'not found', :patch, :update, model: 'Completion'

      context 'when the Completion is found' do
        let(:completion) { create :completion, :member }
        before(:each)    { patch :update, params: { id: completion.id, data: data } }

        context 'when the User does not have permission' do
          let(:data) { nil }
          include_examples 'forbidden'
        end

        context 'when the User has permission' do
          let(:user) { create :user, :admin }

          context 'when the Completion fails to save' do
            let(:data) { { attributes: { rank: -1 } } }

            include_examples 'unprocessable entity'

            it 'is expected to not update the Completion' do
              original_rank = completion.rank
              expect(completion.reload.rank).to eq original_rank
            end
          end

          context 'when the Completion successfully saves' do
            let(:data) { { attributes: { rank: completion.rank == 1 ? completion.rank + 1 : completion.rank - 1 } } }

            include_examples 'ok'

            it 'is expected to update the Completion' do
              expect(completion.reload.rank).to eq data[:attributes][:rank]
            end

            it 'is expected to return the Completion' do
              json = extract_response
              expect(json['data']['type']).to eq 'completions'
              expect(json['data']['id']).to eq completion.id.to_s
              expect(json['data']['attributes']['rank']).to eq data[:attributes][:rank]
            end
          end
        end
      end
    end
  end
end
