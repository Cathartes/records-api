# frozen_string_literal: true

module Queries
  module List
    class Challenges < ::Queries::List::Base
      argument :recordBookId, types.Int, 'ID of a record book to filter results by', as: :record_book_id

      description 'List challenges with various filters'
      type types[::Types::ChallengeType]

      def call(_obj, args, ctx)
        super do
          scope = ctx[:pundit].policy_scope ::Challenge.order :position

          scope = scope.for_record_book args[:record_book_id] if args[:record_book_id].present?

          scope
        end
      end
    end
  end
end
