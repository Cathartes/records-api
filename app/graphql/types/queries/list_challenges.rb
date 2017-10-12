module Types
  module Queries
    class ListChallenges < GraphQL::Function
      argument :recordBookId, types.ID, 'ID of a record book to filter results by'

      description 'List challenges with various filters'
      type types[::Types::ChallengeType]

      def call(_obj, args, _ctx)
        scope = Challenge.all

        scope = scope.for_record_book args[:record_book_id] if args[:record_book_id].present?

        scope
      end
    end
  end
end
