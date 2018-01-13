# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit

  prepend_before_action :set_current_user

  after_action :verify_authorized

  def index
    skip_authorization
    render json: {
      meta: {
        copyright: 'Copyright 2017 Cathartes',
        authors: [
          'Tyler Hogan <tybot204@gmail.com>'
        ]
      }
    }
  end

  protected

  attr_reader :current_user

  def set_current_user
    @current_user = nil
    email = request.headers['X-USER-UID']
    return if email.blank?
    user = User.find_by email: email
    @current_user = user if user&.find_token(request.headers['X-USER-TOKEN']).present?
  end
end
