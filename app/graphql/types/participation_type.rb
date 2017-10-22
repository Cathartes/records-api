module Types
  ParticipationType = GraphQL::ObjectType.define do
    name 'Participation'
    description 'A user competing on a given team within a given record book'

    interfaces [Interfaces::ModelInterface]

    ## Attributes stored in the DB
    field :membershipType, !Enums::UserMembershipTypeEnum, property: :membership_type
    field :teamId, types.Int, property: :team_id

    ## Belongs to associations
    field :recordBook, !RecordBookType, property: :record_book
    field :team, TeamType
    field :user, !UserType

    ## Has many associations
    field :completions, types[!CompletionType]
  end
end
