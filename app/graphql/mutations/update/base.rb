module Mutations
  module Update
    class Base < ::Mutations::Base
      def update_generic(record, args, ctx)
        record.assign_attributes record_args record, args, ctx
        ctx[:pundit].authorize record, :update?
        record.save!
        record
      rescue ActiveRecord::RecordInvalid => error
        GraphQL::ExecutionError.new error.message
      end
    end
  end
end
