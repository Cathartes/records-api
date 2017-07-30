class ApplicationController < ActionController::API
  include Pundit

  after_action :verify_authorized

  def index
    skip_authorization
    head :no_content
  end
end
