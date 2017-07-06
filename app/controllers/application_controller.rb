class ApplicationController < ActionController::API
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :pundit_denied

  after_action :verify_authorized

  def index
    skip_authorization
    render json: {}
  end

  def pundit_denied
    raise NotImplementedError, 'Individual versions of the API must implement "pundit_denied"'
  end
end
