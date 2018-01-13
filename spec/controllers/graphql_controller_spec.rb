# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GraphqlController, type: :controller do
  describe 'post #execute' do
    before { post :execute }
    it { is_expected.to respond_with 200 }
  end
end
