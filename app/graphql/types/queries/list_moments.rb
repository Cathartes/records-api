module Types
  module Queries
    class ListMoments < GraphQL::Function
      argument :recordBookId, types.ID, 'ID of a record book to filter results by'

      description 'List moments with various filters'
      type types[::Types::MomentType]

      def call(_obj, args, _ctx)
        scope = Moment.all
        scope = scope.for_record_book args[:recordBookId] if args[:recordBookId]
        scope
      end
    end
  end
end
