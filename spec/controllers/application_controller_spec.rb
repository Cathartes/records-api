require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe 'GET #index' do
    before(:each) { get :index }
    it { is_expected.to respond_with 200 }
  end
end
