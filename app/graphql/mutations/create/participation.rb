module Mutations
  module Create
    class Participation < Base
      argument :recordBookId, !types.Int, 'ID of a record book to add the participant to', as: :record_book_id
      argument :userId, !types.Int, 'ID of an existing user to add to the record book', as: :user_id
      argument :teamId, types.Int, 'ID of a team to add the participant to', as: :team_id

      description 'Create a single participation within a record book'
      type ::Types::ParticipationType

      def call(_obj, args, ctx)
        create_generic ::Participation, args, ctx
      end
    end
  end
end