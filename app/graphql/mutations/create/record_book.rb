module Mutations
  module Create
    class RecordBook < Base
      argument :name, !types.String, 'Name of the record book'
      argument :published, types.Boolean, 'Whether the Record Book is publically visible'
      argument :startTime, types.String, 'Start time of the first set of challenges', as: :start_time
      argument :endTime, types.String, 'End time for challenges to be completed', as: :end_time
      argument :rushStartTime, types.String, 'Start time of rush week', as: :rush_start_time
      argument :rushEndTime, types.String, 'End time of rush week', as: :rush_end_time

      description 'Create a single record book'
      type ::Types::RecordBookType

      def call(_obj, args, ctx)
        create_generic ::RecordBook.new, args, ctx
      end
    end
  end
end
