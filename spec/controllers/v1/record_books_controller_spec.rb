require 'rails_helper'

require 'support/controllers/auth_helpers'
require 'support/controllers/response_helpers'

RSpec.describe V1::RecordBooksController, type: :controller do
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

        context 'when the Record Book fails to save' do
          let(:data) { { attributes: { name: '' } } }
          include_examples 'unprocessable entity'
        end

        context 'when the Record Book successfully saves' do
          let(:data) { { attributes: { name: Faker::Name.first_name } } }

          include_examples 'created'

          it 'is expected to create the Record Book' do
            expect(RecordBook.count).to eq 1
          end

          it 'is expected to return the Record Book' do
            json = extract_response
            expect(json['data']['type']).to eq 'record_books'
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

      include_examples 'not found', :delete, :destroy, model: 'Record Book'

      context 'when the Record Book is found' do
        let(:record_book) { create :record_book }
        before(:each)     { delete :destroy, params: { id: record_book.id } }

        context 'when the User does not have permission' do
          it { is_expected.to respond_with 403 }
        end

        context 'when the User has permission' do
          let(:user) { create :user, :admin }

          it 'is expected to destroy the Record Book' do
            expect(RecordBook.count).to eq 0
          end

          it { is_expected.to respond_with 204 }
        end
      end
    end
  end

  describe 'GET #index' do
    let!(:published_record_book)   { create :record_book, :published }
    let!(:unpublished_record_book) { create :record_book }

    context 'when no params are passed' do
      context 'when the User is not an admin' do
        before(:each) { get :index }

        include_examples 'ok'

        it 'is expected to return published Record Books' do
          json = extract_response
          expect(json['data'].length).to eq 1
          json['data'].each do |record_book|
            expect(record_book['type']).to eq 'record_books'
            expect(record_book['attributes']['published']).to be true
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

        it 'is expected to return all Record Books' do
          json = extract_response
          expect(json['data'].length).to eq 2
          json['data'].each do |record_book|
            expect(record_book['type']).to eq 'record_books'
          end
        end
      end
    end
  end

  describe 'GET #show' do
    include_examples 'not found', :get, :show, model: 'Record Book'

    context 'when the Record Book is found' do
      before(:each) { get :show, params: { id: record_book.id } }

      context 'when the User does not have permission' do
        let(:record_book) { create :record_book }
        it                { is_expected.to respond_with 403 }
      end

      context 'when the User has permission' do
        let(:record_book) { create :record_book, :published }

        include_examples 'ok'

        it 'is expected to return the Record Book' do
          json = extract_response
          expect(json['data']['type']).to eq 'record_books'
          expect(json['data']['id']).to eq record_book.id.to_s
        end
      end
    end
  end

  describe 'PATCH #update' do
    include_examples 'authentication required', :patch, :update, params: { id: -1 }

    context 'when the User is logged in' do
      let(:user)    { create :user, :claimed }
      before(:each) { authenticate_user user }

      include_examples 'not found', :patch, :update, model: 'Record Book'

      context 'when the Record Book is found' do
        let(:record_book) { create :record_book }
        before(:each)     { patch :update, params: { id: record_book.id, data: data } }

        context 'when the User does not have permission' do
          let(:data) { nil }
          it         { is_expected.to respond_with 403 }
        end

        context 'when the User has permission' do
          let(:user) { create :user, :admin }

          context 'when the Record Book fails to save' do
            let(:data) { { attributes: { name: '' } } }

            it 'is expected to not update the Record Book' do
              original_name = record_book.name
              expect(record_book.reload.name).to eq original_name
            end

            it { is_expected.to respond_with 422 }
          end

          context 'when the Record Book successfully saves' do
            let(:data) { { attributes: { name: record_book.name.first(20) + ' New' } } }

            include_examples 'ok'

            it 'is expected to update the Record Book' do
              expect(record_book.reload.name).to eq data[:attributes][:name]
            end

            it 'is expected to return the Record Book' do
              json = extract_response
              expect(json['data']['type']).to eq 'record_books'
              expect(json['data']['id']).to eq record_book.id.to_s
              expect(json['data']['attributes']['name']).to eq data[:attributes][:name]
            end
          end
        end
      end
    end
  end
end
