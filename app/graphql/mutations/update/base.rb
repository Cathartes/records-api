module Mutations
  module Update
    class Base < ::Mutations::Base
      def update_generic(record, args, ctx)
        record.update_attributes! record_args record, args, ctx
        record
      rescue ActiveRecord::RecordInvalid => error
        GraphQL::ExecutionError.new error.message
      end
    end
  end
end
