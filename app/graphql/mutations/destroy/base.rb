module Mutations
  module Destroy
    class Base < ::Mutations::Base
      def update_status_generic(record, args, ctx)
        record.update(status: 1)
        save_attributes record, args, ctx, type: :update?
      end

      def destroy_generic(record, args, ctx)
        save_attributes record, args, ctx, type: :update?
      end
    end
  end
end
