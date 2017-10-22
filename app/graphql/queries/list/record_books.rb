module Queries
  module List
    class RecordBooks < Base
      description 'List record books with various filters'
      type types[::Types::RecordBookType]

      def call(_obj, _args, ctx)
        super do
          ctx[:pundit].policy_scope ::RecordBook.all
        end
      end
    end
  end
end
