# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::List::Teams do
  describe '.call' do
    let!(:team) { create :team }
    let(:teams) { described_class.new.call({}, args, pundit: GraphqlController.new) }

    context 'when no args are passed' do
      let(:args) { {} }

      it 'returns all teams' do
        expect(teams).to eq [team]
      end
    end
  end
end
