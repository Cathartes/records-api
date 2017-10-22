module Mutations
  module Create
    class Base < ::Mutations::Base
      def create_generic(record, args, ctx)
        record.assign_attributes record_args record, args, ctx
        record.save!
        record
      rescue ActiveRecord::RecordInvalid => error
        GraphQL::ExecutionError.new error.message
      end
    end
  end
end
