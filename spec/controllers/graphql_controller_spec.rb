require 'rails_helper'

RSpec.describe GraphqlController, type: :controller do
  describe 'post #execute' do
    before(:each) { post :execute }
    it { is_expected.to respond_with 200 }
  end
end
