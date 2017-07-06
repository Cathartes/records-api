module V1
  class ApplicationController < ::ApplicationController
    prepend_before_action :check_current_user

    protected

    attr_reader :current_user

    def authenticate_user!
      return if current_user.present?
      render json: {
        errors: [{
          title: 'Unauthorized',
          details: 'You must be logged in to perform this action.'
        }]
      }, status: :unauthorized
    end

    def check_current_user
      @current_user = nil
      email = request.headers['X-USER-EMAIL']
      return if email.blank?
      user = User.find_by email: email
      @current_user = user if user&.find_token(request.headers['X-USER-TOKEN']).present?
    end

    def pundit_denied(exception)
      policy_name = exception.policy.class.to_s.underscore
      locale_name = "#{policy_name}.#{exception.query}"
      render json: {
        errors: [{
          title: 'Access denied',
          details: I18n.t(locale_name, scope: 'pundit', default: :default)
        }]
      }, status: :forbidden
    end

    def unprocessable_entity(model)
      render json: model, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end
end
