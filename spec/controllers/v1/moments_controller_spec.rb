require 'rails_helper'

require 'support/controllers/response_helpers'

RSpec.describe V1::MomentsController, type: :controller do
  describe 'GET #index' do
    context 'when no params are passed' do
      let!(:moment)       { create :moment, :for_new_member }
      let!(:other_moment) { create :moment, :for_new_member }
      before(:each)       { get :index }

      include_examples 'ok'

      it 'is expected to return all Moments' do
        json = extract_response
        expect(json['data'].length).to eq 2
        json['data'].each do |moment|
          expect(moment['type']).to eq 'moments'
        end
      end
    end

    context 'when "record_book_id" is passed' do
      let!(:moment)       { create :moment, :for_new_member }
      let!(:other_moment) { create :moment, :for_new_member }
      before(:each)       { get :index, params: { record_book_id: moment.record_book_id } }

      include_examples 'ok'

      it 'is expected to return Moments for the Record Book' do
        json = extract_response
        expect(json['data'].length).to eq 1
        json['data'].each do |moment|
          expect(moment['type']).to eq 'moments'
        end
      end
    end
  end
end
