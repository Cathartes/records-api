module Mutations
  module Create
    class Completion < Base
      argument :challengeId, !types.Int, 'ID of a challenge the participant completed', as: :challenge_id
      argument :participationId, !types.Int, 'ID of the participation completing the challenge', as: :participation_id
      argument :points, types.Int, 'Override the number of points given'
      argument :rank, types.Int, 'Override rank to assign points to this completion'
      argument :status, ::Types::Enums::CompletionStatusEnum, 'Status this completion is in'

      description 'Create a single completion for a challenge by a participant'
      type ::Types::CompletionType

      def call(_obj, args, ctx)
        create_generic ::Completion.new, args, ctx
      end
    end
  end
end
