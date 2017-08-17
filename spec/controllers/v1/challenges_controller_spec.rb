require 'rails_helper'

require 'support/controllers/auth_helpers'
require 'support/controllers/response_helpers'

RSpec.describe V1::ChallengesController, type: :controller do
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
        it         { is_expected.to respond_with 403 }
      end

      context 'when the User has permission' do
        let(:user) { create :user, :admin }

        context 'when the Challenge fails to save' do
          let(:data) { { attributes: { name: '' } } }
          include_examples 'unprocessable entity'
        end

        context 'when the Challenge successfully saves' do
          let(:record_book) { create :record_book }
          let(:data) do
            {
              attributes: {
                name: Faker::Name.first_name,
                record_book_id: record_book.id,
                max_completions: Faker::Number.between(0, 10),
                points: { 0 => 1 }
              }
            }
          end

          include_examples 'created'

          it 'is expected to create the Challenge' do
            expect(Challenge.count).to eq 1
          end

          it 'is expected to return the Challenge' do
            json = extract_response
            expect(json['data']['type']).to eq 'challenges'
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

      include_examples 'not found', :delete, :destroy, model: 'Challenge'

      context 'when the Challenge is found' do
        let(:challenge) { create :challenge }
        before(:each)   { delete :destroy, params: { id: challenge.id } }

        context 'when the User does not have permission' do
          it { is_expected.to respond_with 403 }
        end

        context 'when the User has permission' do
          let(:user) { create :user, :admin }

          it 'is expected to destroy the Challenge' do
            expect(Challenge.count).to eq 0
          end

          it { is_expected.to respond_with 204 }
        end
      end
    end
  end

  describe 'GET #index' do
    context 'when no params are passed' do
      let!(:published_challenge)   { create :challenge, :published }
      let!(:unpublished_challenge) { create :challenge }

      context 'when the User is not an admin' do
        before(:each) { get :index }

        include_examples 'ok'

        it 'is expected to return published Challenges' do
          json = extract_response
          expect(json['data'].length).to eq 1
          json['data'].each do |challenge|
            expect(challenge['type']).to eq 'challenges'
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

        it 'is expected to return all Challenges' do
          json = extract_response
          expect(json['data'].length).to eq 2
          json['data'].each do |challenge|
            expect(challenge['type']).to eq 'challenges'
          end
        end
      end
    end

    context 'when "record_book_id" is passed' do
      let!(:challenge)       { create :challenge, :published }
      let!(:other_challenge) { create :challenge, :published }
      before(:each)          { get :index, params: { record_book_id: challenge.record_book_id } }

      include_examples 'ok'

      it 'is expected to return Challenges within the Record Book' do
        json = extract_response
        expect(json['data'].length).to eq 1
        json['data'].each do |challenge|
          expect(challenge['type']).to eq 'challenges'
        end
        challenge_ids = json['data'].map { |challenge| challenge['id'] }
        expect(challenge_ids).to include challenge.id.to_s
      end
    end
  end

  describe 'GET #show' do
    include_examples 'not found', :get, :show, model: 'Challenge'

    context 'when the Challenge is found' do
      before(:each) { get :show, params: { id: challenge.id } }

      context 'when the User does not have permission' do
        let(:challenge) { create :challenge }
        it              { is_expected.to respond_with 403 }
      end

      context 'when the User has permission' do
        let(:challenge) { create :challenge, :published }

        include_examples 'ok'

        it 'is expected to return the Challenge' do
          json = extract_response
          expect(json['data']['type']).to eq 'challenges'
          expect(json['data']['id']).to eq challenge.id.to_s
        end
      end
    end
  end

  describe 'PATCH #update' do
    include_examples 'authentication required', :patch, :update, params: { id: -1 }

    context 'when the User is logged in' do
      let(:user)    { create :user, :claimed }
      before(:each) { authenticate_user user }

      include_examples 'not found', :patch, :update, model: 'Challenge'

      context 'when the Challenge is found' do
        let(:challenge) { create :challenge }
        before(:each)   { patch :update, params: { id: challenge.id, data: data } }

        context 'when the User does not have permission' do
          let(:data) { nil }
          it         { is_expected.to respond_with 403 }
        end

        context 'when the User has permission' do
          let(:user) { create :user, :admin }

          context 'when the Challenge fails to save' do
            let(:data) { { attributes: { name: '' } } }

            it 'is expected to not update the Challenge' do
              original_name = challenge.name
              expect(challenge.reload.name).to eq original_name
            end

            it { is_expected.to respond_with 422 }
          end

          context 'when the Challenge successfully saves' do
            let(:data) { { attributes: { name: challenge.name.first(20) + ' New' } } }

            include_examples 'ok'

            it 'is expected to update the Challenge' do
              expect(challenge.reload.name).to eq data[:attributes][:name]
            end

            it 'is expected to return the Challenge' do
              json = extract_response
              expect(json['data']['type']).to eq 'challenges'
              expect(json['data']['id']).to eq challenge.id.to_s
              expect(json['data']['attributes']['name']).to eq data[:attributes][:name]
            end
          end
        end
      end
    end
  end
end
