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
        let(:data) { { attributes: { participation_type: :member } } }
        include_examples 'forbidden'
      end

      context 'when the User has permission' do
        let(:user) { create :user, :admin }

        context 'when the Participation fails to save' do
          let(:data) { { attributes: { participation_type: :member } } }
          include_examples 'unprocessable entity'
        end

        context 'when the Participation successfully saves' do
          let(:record_book) { create :record_book }
          let(:team)        { create :team }
          let(:data) do
            {
              attributes: {
                participation_type: :member,
                record_book_id: record_book.id,
                team_id: team.id,
                user_id: user.id
              }
            }
          end

          include_examples 'created'

          it 'is expected to create the Participation' do
            expect(Participation.count).to eq 1
          end

          it 'is expected to return the Participation' do
            json = extract_response
            expect(json['data']['type']).to eq 'participations'
            expect(json['data']['attributes']['participation_type']).to eq data[:attributes][:participation_type].to_s
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
        let(:participation) { create :participation, :member }
        before(:each)       { delete :destroy, params: { id: participation.id } }

        context 'when the User does not have permission' do
          include_examples 'forbidden'
        end

        context 'when the User has permission' do
          let(:user) { create :user, :admin }

          include_examples 'no content'

          it 'is expected to destroy the Participation' do
            expect(Participation.count).to eq 0
          end
        end
      end
    end
  end

  describe 'GET #index' do
    context 'when no params are passed' do
      let!(:participation)       { create :participation, :member }
      let!(:other_participation) { create :participation, :member }
      before(:each)              { get :index }

      include_examples 'ok'

      it 'is expected to return all Participations' do
        json = extract_response
        expect(json['data'].length).to eq 2
        json['data'].each do |participation|
          expect(participation['type']).to eq 'participations'
        end
      end
    end

    context 'when "record_book_id" is passed' do
      let!(:participation)       { create :participation, :member }
      let!(:other_participation) { create :participation, :member }
      before(:each)              { get :index, params: { record_book_id: participation.record_book_id } }

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
      let!(:participation)       { create :participation, :member }
      let!(:other_participation) { create :participation, :member }
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
      let!(:participation)       { create :participation, :member }
      let!(:other_participation) { create :participation, :member }
      before(:each)              { get :index, params: { user_id: participation.user_id } }

      include_examples 'ok'

      it 'is expected to return Participations for the User' do
        json = extract_response
        expect(json['data'].length).to eq 1
        json['data'].each do |participation|
          expect(participation['type']).to eq 'participations'
        end
      end
    end

    context 'when "participation_type" is passed' do
      let!(:member_participation)    { create :participation, :member }
      let!(:applicant_participation) { create :participation, :applicant }

      context 'when "participation_type" is "member"' do
        before(:each) { get :index, params: { participation_type: :member } }

        include_examples 'ok'

        it 'is expected to return member Participations' do
          json = extract_response
          expect(json['data'].length).to eq 1
          json['data'].each do |participation|
            expect(participation['type']).to eq 'participations'
            expect(participation['attributes']['participation_type']).to eq 'member'
          end
        end
      end

      context 'when "participation_type" is "applicant"' do
        before(:each) { get :index, params: { participation_type: :applicant } }

        include_examples 'ok'

        it 'is expected to return applicant Participations' do
          json = extract_response
          expect(json['data'].length).to eq 1
          json['data'].each do |participation|
            expect(participation['type']).to eq 'participations'
            expect(participation['attributes']['participation_type']).to eq 'applicant'
          end
        end
      end
    end
  end

  describe 'GET #show' do
    include_examples 'not found', :get, :show, model: 'Participation'

    context 'when the Participation is found' do
      let(:participation) { create :participation, :member }
      before(:each)       { get :show, params: { id: participation.id } }

      context 'when the User does not have permission' do
        include_examples 'forbidden'
      end

      context 'when the User has permission' do
        let(:participation) { create :participation, :member, :published }

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
        let(:participation) { create :participation, :member }
        before(:each)       { patch :update, params: { id: participation.id, data: data } }

        context 'when the User does not have permission' do
          let(:data) { nil }
          include_examples 'forbidden'
        end

        context 'when the User has permission' do
          let(:user) { create :user, :admin }

          context 'when the Participation fails to save' do
            let(:data) { { attributes: { participation_type: nil } } }

            include_examples 'unprocessable entity'

            it 'is expected to not update the Participation' do
              participation_type = participation.participation_type
              expect(participation.reload.participation_type).to eq participation_type
            end
          end

          context 'when the Participation successfully saves' do
            let(:data) { { attributes: { participation_type: :applicant } } }

            include_examples 'ok'

            it 'is expected to update the Participation' do
              expect(participation.reload.participation_type).to eq data[:attributes][:participation_type].to_s
            end

            it 'is expected to return the Participation' do
              json = extract_response
              expect(json['data']['type']).to eq 'participations'
              expect(json['data']['id']).to eq participation.id.to_s
              expect(json['data']['attributes']['participation_type']).to eq data[:attributes][:participation_type].to_s
            end
          end
        end
      end
    end
  end
end
