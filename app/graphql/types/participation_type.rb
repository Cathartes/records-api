module Types
  ParticipationType = GraphQL::ObjectType.define do
    name 'Participation'
    description 'A user competing on a given team within a given record book'

    interfaces [Interfaces::ModelInterface]

    ## Belongs to associations
    field :recordBook, !ParticipationType, property: :record_book
    field :team, !TeamType
    field :user, !UserType

    ## Has many associations
    field :completions, types[!CompletionType]
  end
end
