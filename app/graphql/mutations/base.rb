# frozen_string_literal: true

module Mutations
  class Base < GraphQL::Function
    def record_args(record, args, ctx)
      attrs = ctx[:pundit].policy(record).permitted_attributes
      args.to_h.select { |k, _v| attrs.include? k.to_sym }
    end

    def save_attributes(record, args, ctx, type:)
      record.assign_attributes record_args record, args, ctx
      ctx[:pundit].authorize record, type
      record.save!
      record
    rescue ActiveRecord::RecordInvalid => error
      GraphQL::ExecutionError.new error.message
    end
  end
end
