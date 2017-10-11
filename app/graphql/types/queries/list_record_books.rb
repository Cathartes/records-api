module Types
  module Queries
    class ListRecordBooks < GraphQL::Function
      description 'List record books with various filters'
      type types[::Types::RecordBookType]

      def call(_obj, _args, _ctx)
        RecordBook.all
      end
    end
  end
end
