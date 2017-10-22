module Queries
  class ListParticipations < ListRecords
    argument :recordBookId, types.Int, 'ID of a record book to filter results by', as: :record_book_id
    argument :teamId, types.Int, 'ID of a team to filter results by', as: :team_id
    argument :userId, types.Int, 'ID of a user to filter results by', as: :user_id

    description 'List participations with various filters'
    type types[::Types::ParticipationType]

    def call(_obj, args, ctx)
      super do
        scope = ctx[:pundit].policy_scope Participation.all

        scope = scope.for_record_book args[:record_book_id] if args[:record_book_id].present?

        scope = scope.for_team args[:team_id] if args[:team_id].present?

        scope = scope.for_user args[:user_id] if args[:user_id].present?

        scope
      end
    end
  end
end
