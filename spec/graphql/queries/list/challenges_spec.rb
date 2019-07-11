# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::List::Challenges do
  describe '.call' do
    let!(:challenge)             { create :challenge, :published }
    let!(:record_book_challenge) { create :challenge, :published }

    let(:challenges) { described_class.new.call({}, args, pundit: GraphqlController.new) }

    context 'when no args are passed' do
      let(:args) { {} }

      it 'returns all challenges' do
        expect(challenges).to eq [challenge, record_book_challenge]
      end
    end

    context 'when record_book_id is passed' do
      let(:args) { { record_book_id: record_book_challenge.record_book_id } }

      it 'returns challenges for the record book' do
        expect(challenges).to eq [record_book_challenge]
      end
    end
  end
end
