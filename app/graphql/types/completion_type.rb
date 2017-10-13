module Types
  CompletionType = GraphQL::ObjectType.define do
    name 'Completion'
    description 'An instance of a user completing a challenge during a record book'

    interfaces [Interfaces::ModelInterface]

    ## Attributes stored in the DB
    field :rank, !types.Int
    field :points, !types.Int
    field :status, !Enums::CompletionStatusEnum

    ## Belongs to associations
    field :challenge, !ChallengeType
    field :participation, !ParticipationType

    ## Has one associations
    field :record_book, !RecordBookType
    field :user, !UserType
  end
end
