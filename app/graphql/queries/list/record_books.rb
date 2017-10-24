module Queries
  module List
    class RecordBooks < ::Queries::List::Base
      description 'List record books with various filters'
      type types[::Types::RecordBookType]

      def call(_obj, _args, ctx)
        super do
          ctx[:pundit].policy_scope ::RecordBook.order :created_at
        end
      end
    end
  end
end
