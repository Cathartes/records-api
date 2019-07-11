# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::List::RecordBooks do
  describe '.call' do
    let!(:record_book) { create :record_book, :published }
    let(:record_books) { described_class.new.call({}, args, pundit: GraphqlController.new) }

    context 'when no args are passed' do
      let(:args) { {} }

      it 'returns all record books' do
        expect(record_books).to eq [record_book]
      end
    end
  end
end
