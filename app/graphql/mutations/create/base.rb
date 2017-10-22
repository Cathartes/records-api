module Mutations
  module Create
    class Base < ::Mutations::Base
      def create_generic(record, args, ctx)
        save_attributes record, args, ctx, type: :create?
      end
    end
  end
end
