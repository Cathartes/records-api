module Mutations
  class Base < GraphQL::Function
    def record_args(record, args, ctx)
      attrs = ctx[:pundit].policy(record).permitted_attributes
      args.to_h.select { |k, _v| attrs.include? k.to_sym }
    end
  end
end
