class BooleanValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, 'must be a boolean' unless [true, false].include? value
  end
end
