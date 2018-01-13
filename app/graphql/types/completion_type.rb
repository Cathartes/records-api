# frozen_string_literal: true

module Types
  CompletionType = GraphQL::ObjectType.define do
    name 'Completion'
    description 'An instance of a user completing a challenge during a record book'

    interfaces [Interfaces::ModelInterface]

    ## Attributes stored in the DB
    field :challengeId, !types.Int, property: :challenge_id
    field :participationId, !types.Int, property: :participation_id
    field :points, !types.Int
    field :rank, !types.Int
    field :status, !Enums::CompletionStatusEnum

    ## Belongs to associations
    field :challenge, !ChallengeType do
      resolve ->(obj, _args, _ctx) { FindLoader.for(Challenge).load obj.challenge_id }
    end
    field :participation, !ParticipationType do
      resolve ->(obj, _args, _ctx) { FindLoader.for(Participation).load obj.participation_id }
    end

    ## Has one associations
    field :record_book, !RecordBookType
    field :user, !UserType
  end
end
