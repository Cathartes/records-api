module Mutations
  module Destroy
    class Base < ::Mutations::Base
      def destroy_generic(record)
        record.destroy
      end
    end
  end
end
