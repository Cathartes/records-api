module Mutations
  module Update
    class Base < ::Mutations::Base
      def update_generic(record, args, ctx)
        save_attributes record, args, ctx, type: :update?
      end
    end
  end
end
