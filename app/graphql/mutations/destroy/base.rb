module Mutations
  module Destroy
    class Base < ::Mutations::Base
      def destroy_generic(record, ctx)
        ctx[:pundit].authorize record, :destroy?
        record.destroy
      end
    end
  end
end
