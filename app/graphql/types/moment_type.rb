module Types
  MomentType = GraphQL::ObjectType.define do
    name 'Moment'
    description 'An event within a record book; either a user gaining membership or completing a challenge'

    interfaces [Interfaces::ModelInterface]

    ## Attributes stored in the DB
    field :momentType, !Enums::MomentMomentTypeEnum, property: :moment_type

    ## Belongs to associations
    field :recordBook, !RecordBookType, property: :record_book
    field :completion, CompletionType
    field :participation, !ParticipationType
    field :user, UserType
  end
end
