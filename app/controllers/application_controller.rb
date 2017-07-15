class ApplicationController < ActionController::API
  include Pundit

  after_action :verify_authorized

  def index
    skip_authorization
    render json: {}
  end
end
