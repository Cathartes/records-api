# frozen_string_literal: true

module Mutations
  module Update
    class Challenge < ::Mutations::Update::Base
      argument :id, !types.Int, 'ID of the challenge to update'
      argument :recordBookId, types.Int, 'ID of a record book the challenge is a part of', as: :record_book_id
      argument :challengeType, ::Types::Enums::ChallengeTypeEnum, 'Type of user can complete this challenge', as: :challenge_type
      argument :name, types.String, 'Name of the challenge'
      argument :pointsCompletion, types.Int, 'Minimum points given for completing the challenge', as: :points_completion
      argument :pointsFirst, types.Int, 'Points given to the first member to complete the challenge', as: :points_first
      argument :pointsSecond, types.Int, 'Points given to the second member to complete the challenge', as: :points_second
      argument :pointsThird, types.Int, 'Points given to the third member to complete the challenge', as: :points_third
      argument :position, types.Int, 'Position to order challenges in display lists'

      description 'Update a single record book'
      type ::Types::ChallengeType

      def call(_obj, args, ctx)
        challenge = ::Challenge.find args[:id]
        update_generic challenge, args, ctx
      end
    end
  end
end
