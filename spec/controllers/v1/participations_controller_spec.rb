require 'rails_helper'

require 'support/controllers/auth_helpers'
require 'support/controllers/response_helpers'

RSpec.describe V1::ParticipationsController, type: :controller do
  describe 'POST #create' do
    include_examples 'authentication required', :post, :create

    context 'when the User is logged in' do
      before(:each) do
        authenticate_user user
        post :create, params: { data: data }
      end

      context 'when the User does not have permission' do
        let(:user) { create :user, :claimed }
        let(:data) { { attributes: { record_book_id: -1 } } }
        include_examples 'forbidden'
      end

      context 'when the User has permission' do
        let(:user) { create :user, :admin }

        context 'when the Participation fails to save' do
          let(:data) { { attributes: { record_book_id: -1 } } }
          include_examples 'unprocessable entity'
        end

        context 'when the Participation successfully saves' do
          let(:record_book) { create :record_book }
          let(:team)        { create :team }
          let(:data) do
            {
              attributes: {
                record_book_id: record_book.id,
                team_id: team.id,
                user_id: user.id
              }
            }
          end

          include_examples 'created'

          it 'is expected to create the Participation' do
            expect(Participation.count).to eq 2
          end

          it 'is expected to return the Participation' do
            json = extract_response
            expect(json['data']['type']).to eq 'participations'
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

      include_examples 'not found', :delete, :destroy, model: 'Participation'

      context 'when the Participation is found' do
        let(:participation) { create :participation }
        before(:each)       { delete :destroy, params: { id: participation.id } }

        context 'when the User does not have permission' do
          include_examples 'forbidden'
        end

        context 'when the User has permission' do
          let(:user) { create :user, :admin }

          include_examples 'no content'

          it 'is expected to destroy the Participation' do
            expect(Participation.count).to eq 1
          end
        end
      end
    end
  end

  describe 'GET #index' do
    context 'when no params are passed' do
      let!(:participation)       { create :participation }
      let!(:other_participation) { create :participation }
      before(:each)              { get :index }

      include_examples 'ok'

      it 'is expected to return all Participations' do
        json = extract_response
        expect(json['data'].length).to eq 3
        json['data'].each do |participation|
          expect(participation['type']).to eq 'participations'
        end
      end
    end

    context 'when "record_book_id" is passed' do
      let!(:participation)       { create :participation }
      let!(:other_participation) { create :participation }
      before(:each)              { get :index, params: { record_book_id: participation.record_book_id.to_s } }

      include_examples 'ok'

      it 'is expected to return Participations for the Record Book' do
        json = extract_response
        expect(json['data'].length).to eq 1
        json['data'].each do |participation|
          expect(participation['type']).to eq 'participations'
        end
      end
    end

    context 'when "team_id" is passed' do
      let!(:participation)       { create :participation }
      let!(:other_participation) { create :participation }
      before(:each)              { get :index, params: { team_id: participation.team_id } }

      include_examples 'ok'

      it 'is expected to return Participations for the Team' do
        json = extract_response
        expect(json['data'].length).to eq 1
        json['data'].each do |participation|
          expect(participation['type']).to eq 'participations'
        end
      end
    end

    context 'when "user_id" is passed' do
      let!(:participation)       { create :participation }
      let!(:other_participation) { create :participation }
      before(:each)              { get :index, params: { user_id: participation.user_id } }

      include_examples 'ok'

      it 'is expected to return Participations for the User' do
        json = extract_response
        expect(json['data'].length).to eq 2
        json['data'].each do |participation|
          expect(participation['type']).to eq 'participations'
        end
      end
    end
  end

  describe 'GET #show' do
    include_examples 'not found', :get, :show, model: 'Participation'

    context 'when the Participation is found' do
      let(:participation) { create :participation }
      before(:each)       { get :show, params: { id: participation.id } }

      context 'when the User does not have permission' do
        include_examples 'forbidden'
      end

      context 'when the User has permission' do
        let(:participation) { create :participation, :published }

        include_examples 'ok'

        it 'is expected to return the Participation' do
          json = extract_response
          expect(json['data']['type']).to eq 'participations'
          expect(json['data']['id']).to eq participation.id.to_s
        end
      end
    end
  end

  describe 'PATCH #update' do
    include_examples 'authentication required', :patch, :update, params: { id: -1 }

    context 'when the User is logged in' do
      let(:user)    { create :user, :claimed }
      before(:each) { authenticate_user user }

      include_examples 'not found', :patch, :update, model: 'Participation'

      context 'when the Participation is found' do
        let(:participation) { create :participation }
        before(:each)       { patch :update, params: { id: participation.id, data: data } }

        context 'when the User does not have permission' do
          let(:data) { nil }
          include_examples 'forbidden'
        end

        context 'when the User has permission' do
          let(:user) { create :user, :admin }

          context 'when the Participation fails to save' do
            let(:data) { { attributes: { record_book_id: -1 } } }

            include_examples 'unprocessable entity'

            it 'is expected to not update the Participation' do
              record_book_id = participation.record_book_id
              expect(participation.reload.record_book_id).to eq record_book_id
            end
          end

          context 'when the Participation successfully saves' do
            let(:record_book) { create :record_book }
            let(:data)        { { attributes: { record_book_id: record_book.id } } }

            include_examples 'ok'

            it 'is expected to update the Participation' do
              expect(participation.reload.record_book_id).to eq data[:attributes][:record_book_id]
            end

            it 'is expected to return the Participation' do
              json = extract_response
              expect(json['data']['type']).to eq 'participations'
              expect(json['data']['id']).to eq participation.id.to_s
            end
          end
        end
      end
    end
  end
end
