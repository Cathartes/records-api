module ApplicationDoc
  extend Apipie::DSL::Concern

  attr_reader :namespace_version

  def namespace(namespace)
    @namespace = namespace
    @namespace_version = namespace.split('/').first
  end

  def resource(resource)
    controller_name = resource.to_s.camelize + 'Controller'
    (class << self; self; end).send :define_method, :superclass do
      mod = @namespace.present? ? @namespace.split('/').map(&:capitalize).join('::').constantize : Object
      mod.const_get controller_name
    end
    Apipie.app.set_resource_id self, controller_name
    resource_description do
      formats [:json]
    end
  end

  def defaults(&block)
    @defaults = block
  end

  def doc_for(action_name, &block)
    instance_eval(&block)
    instance_eval(&@defaults) if @defaults.present?
    api_version namespace_version if namespace_version
    define_method(action_name) do |*args, &blk|
      super(*args, &blk)
    end
  end

  def json_api_wrap(&block)
    param :data, Hash, 'Standard JSON API data wrapper', required: true do
      param :attributes, Hash, 'Standard JSON API attributes wrapper', required: true do
        instance_eval(&block)
      end
    end
  end

  def authentication_headers(required: true)
    header :'X-USER-UID', 'Unique identifier for the current user', required: required
    header :'X-USER-TOKEN', 'Authentication token to verify the current user', required: required
    error :unauthorized, 'Unauthorized' if required
  end

  def not_found_error(klass)
    error :not_found, "#{klass} with given ID was not found"
  end

  def pagination_params
    param :page, Hash, 'Hash og pagination parameters' do
      param :number, Integer, 'Page number to return', required: true
      param :size, Integer, 'Number of results to return in each page'
    end
  end

  def unprocessable_entity_error(klass)
    error :unprocessable_entity, "#{klass} failed to save with the given parameters"
  end
end
