module Mutations
  module Update
    class RecordBook < ::Mutations::Update::Base
      argument :id, !types.Int, 'ID of the record book to update'
      argument :name, types.String, 'Name of the record book'
      argument :published, types.Boolean, 'Whether the Record Book is publically visible'
      argument :rushWeekActive, types.Boolean, 'Whether rush week challenges are active', as: :rush_week_active
      argument :startTime, types.String, 'Start time of the first set of challenges', as: :start_time
      argument :endTime, types.String, 'End time for challenges to be completed', as: :end_time
      argument :rushStartTime, types.String, 'Start time of rush week', as: :rush_start_time
      argument :rushEndTime, types.String, 'End time of rush week', as: :rush_end_time

      description 'Update a single record book'
      type ::Types::RecordBookType

      def call(_obj, args, ctx)
        record_book = ::RecordBook.find args[:id]
        update_generic record_book, args, ctx
      end
    end
  end
end
