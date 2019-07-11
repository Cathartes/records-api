# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::List::Participations do
  describe '.call' do
    let!(:record_book_participation) { create :participation }
    let!(:team_participation) { create :participation }
    let!(:user_participation) { create :participation }

    let(:participations) { described_class.new.call({}, args, pundit: GraphqlController.new) }

    context 'when no args are passed' do
      let(:args) { {} }

      it 'returns all participations' do
        expect(participations).to include record_book_participation, team_participation, user_participation
      end
    end

    context 'when record_book_id is passed' do
      let(:args) { { record_book_id: record_book_participation.record_book_id } }

      it 'returns participations for the record book' do
        expect(participations).to eq [record_book_participation]
      end
    end

    context 'when team_id is passed' do
      let(:args) { { team_id: team_participation.team_id } }

      it 'returns participations for the team' do
        expect(participations).to eq [team_participation]
      end
    end

    context 'when user_id is passed' do
      let(:args) { { user_id: user_participation.user_id } }

      it 'returns participations for the user' do
        expect(participations).to eq [user_participation]
      end
    end
  end
end
