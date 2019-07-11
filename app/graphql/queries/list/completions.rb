# frozen_string_literal: true

module Queries
  module List
    class Completions < ::Queries::List::Base
      argument :participationId, types.Int, 'ID of a participation to filter results by', as: :participation_id
      argument :recordBookId, types.Int, 'ID of a record book to filter results by', as: :record_book_id
      argument :status, Types::Enums::CompletionStatusEnum, 'Type of completion to filter results by'
      argument :userId, types.Int, 'ID of a user to filter results by', as: :user_id

      description 'List completions with various filters'
      type !types[::Types::CompletionType]

      def call(_obj, args, ctx)
        super do
          scope = ctx[:pundit].policy_scope ::Completion.order :created_at

          scope = scope.for_participation args[:participation_id] if args[:participation_id].present?

          scope = scope.for_record_book args[:record_book_id] if args[:record_book_id].present?

          scope = case args[:status]
                  when 'pending'
                    scope.pending
                  when 'approved'
                    scope.approved
                  when 'declined'
                    scope.declined
                  else
                    scope
                  end

          scope = scope.for_user args[:user_id] if args[:user_id].present?

          scope
        end
      end
    end
  end
end
