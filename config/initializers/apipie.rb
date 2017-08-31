Apipie.configure do |config|
  config.app_name                = 'Records API'
  config.api_base_url            = nil
  config.doc_base_url            = '/docs'
  config.default_version         = 'v1'
  config.default_locale          = nil
  config.app_info                = 'The official Cathartes Record Book API.'
  config.validate                = !Rails.env.test?

  ## rubocop:disable Rails/FilePath
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/{[!concerns/]**/*,*}.rb"
  ## rubocop:enable Rails/FilePath
end

class CommaArrayValidator < Apipie::Validator::BaseValidator
  def self.build(param_description, argument, options, _block)
    new param_description, options if argument == :comma_array && options.key?(:in)
  end

  def initialize(param_description, options = {})
    super(param_description)
    @items_enum = options[:in]
  end

  def description
    "Must be a comma separated list of #{@items_enum.inspect}."
  end

  def process_value(value)
    value.split(',') || []
  end

  def validate(value)
    return false unless value.is_a?(String)
    process_value(value).all? { |v| @items_enum.include?(v) }
  end
end

class DateTimeValidator < Apipie::Validator::BaseValidator
  def self.build(param_description, argument, _options, _block)
    new param_description if argument == :date_time
  end

  def description
    'Must be in the format YYYY-MM-DDTHH:MMZ. Time and time zone optional.'
  end

  def validate(value)
    value.to_s =~ /\A\d{4}-\d{1,2}-\d{1,2}(T\d{1,2}:\d{1,2}([+-]\d{1,2}(:?\d{1,2})?)?)?\Z/
  end
end

class IntegerValidator < Apipie::Validator::BaseValidator
  def self.build(param_description, argument, _options, _block)
    new param_description if argument == Integer
  end

  def description
    'Must be an integer.'
  end

  def validate(value)
    return false if value.nil?
    value.to_s =~ /^[-+]?[0-9]+$/
  end
end
