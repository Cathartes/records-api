module Queries
  class ListParticipations < GraphQL::Function
    argument :recordBookId, types.ID, 'ID of a record book to filter results by'
    argument :teamId, types.ID, 'ID of a team to filter results by'
    argument :userId, types.ID, 'ID of a user to filter results by'

    description 'List participations with various filters'
    type types[::Types::ParticipationType]

    def call(_obj, args, _ctx)
      scope = Participation.all

      scope = scope.for_record_book args[:record_book_id] if args[:record_book_id].present?

      scope = scope.for_team args[:team_id] if args[:team_id].present?

      scope = scope.for_user args[:user_id] if args[:user_id].present?

      scope
    end
  end
end
