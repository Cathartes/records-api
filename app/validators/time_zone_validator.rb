class TimeZoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    time_zones = ActiveSupport::TimeZone.all.map { |tz| [tz.name, tz.tzinfo.name] }.flatten
    record.errors.add attribute, 'must be a valid IANA time zone' unless time_zones.include? value
  end
end
