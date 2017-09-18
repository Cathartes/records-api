class ApplicationController < ActionController::API
  include Pundit

  after_action :verify_authorized

  def index
    skip_authorization
    render json: {
      jsonapi: { version: '1.0' },
      meta: {
        copyright: 'Copyright 2017 Cathartes',
        authors: [
          'Tyler Hogan <tybot204@gmail.com>'
        ]
      }
    }
  end
end
