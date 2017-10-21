module Mutations
  class UpdateChallenge < GraphQL::Function
    argument :id, !types.ID, 'ID of the challenge to update'
    argument :recordBookId, types.ID, 'ID of a record book the challenge is a part of', as: :record_book_id
    argument :maxCompletions, types.Int, 'Max number of times a member can complete this challenge', as: :max_completions
    argument :name, types.String, 'Name of the challenge'
    argument :pointsCompletion, types.Int, 'Minimum points given for completing the challenge', as: :points_completion
    argument :pointsFirst, types.Int, 'Points given to the first member to complete the challenge', as: :points_first
    argument :pointsSecond, types.Int, 'Points given to the second member to complete the challenge', as: :points_second
    argument :pointsThird, types.Int, 'Points given to the third member to complete the challenge', as: :points_third
    argument :position, types.Int, 'Position to order challenges in display lists'

    description 'Update a single record book'
    type ::Types::ChallengeType

    def call(_obj, args, ctx)
      @challenge = Challenge.find args[:id]
      @challenge.update_attributes challenge_args args, ctx
      @challenge
    end

    def challenge_args(args, ctx)
      attrs = Pundit.policy(ctx[:current_user], @challenge).permitted_attributes
      args.to_h.select { |k, _v| attrs.include? k.to_sym }
    end
  end
end
