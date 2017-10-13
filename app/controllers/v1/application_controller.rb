module V1
  class ApplicationController < ::ApplicationController
    include PaginationHelpers

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from Apipie::ParamError, with: :bad_request
    rescue_from Pundit::NotAuthorizedError, with: :pundit_denied

    protected

    def authenticate_user!
      return if current_user.present?
      render json: {
        errors: [{
          title: 'Unauthorized',
          details: 'You must be logged in to perform this action.'
        }]
      }, status: :unauthorized
    end

    def bad_request(exception)
      render json: {
        errors: [{
          title: 'Invalid parameters',
          detail: exception.message
        }]
      }, status: :bad_request
    end

    def parse_includes(default_includes = [])
      include_param = params[:include]
      return default_includes if include_param.blank?

      include_hash = {}
      default_includes.each do |default|
        if default.is_a? Hash
          include_hash[default.keys.first.to_s] = default.values.first.map(&:to_s)
          default.values.first.each do |value|
            include_hash[value.to_s] = []
          end
        else
          include_hash[default.to_s] = []
        end
      end

      include_segments = include_param.split(',')
      include_segments.each do |segment|
        parent, *nested = segment.split('.')
        include_hash[parent] ||= []

        if nested.any?
          include_segments.append nested.join('.')
          include_hash[parent] << nested.first unless include_hash[parent].include? nested.first
        end
      end

      reject_keys = []
      include_hash.each do |_parent, child|
        relations = child.dup
        relations.each do |relation|
          reject_keys << relation
          child_relations = include_hash[relation]
          next if child_relations.empty?
          child.delete(relation)
          child << { relation => child_relations }
        end
      end

      include_hash.map do |k, v|
        next if reject_keys.include? k
        v.any? ? { k => v } : k
      end.compact
    end

    def pundit_denied(exception)
      policy_name = exception.policy.class.to_s.underscore
      locale_name = "#{policy_name}.#{exception.query}"
      render json: {
        errors: [{
          title: 'Access Denied',
          details: I18n.t(locale_name, scope: 'pundit', default: :default)
        }]
      }, status: :forbidden
    end

    def record_not_found(exception)
      render json: {
        errors: [{
          title: 'Not Found',
          details: exception.message
        }]
      }, status: :not_found
    end

    def unprocessable_entity(model)
      render json: model, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end
end
