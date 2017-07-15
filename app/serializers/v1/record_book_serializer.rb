module V1
  class RecordBookSerializer < ApplicationSerializer
    ## Model attributes
    attributes :end_time, :name, :published, :rush_end_time, :rush_start_time, :start_time, :time_zone
  end
end
