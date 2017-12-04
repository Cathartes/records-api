module Types
  ParticipationType = GraphQL::ObjectType.define do
    name 'Participation'
    description 'A user competing on a given team within a given record book'

    interfaces [Interfaces::ModelInterface]

    ## Attributes stored in the DB
    field :membershipType, !Enums::UserMembershipTypeEnum, property: :membership_type
    field :teamId, types.Int, property: :team_id

    ## Belongs to associations
    field :recordBook, !RecordBookType do
      resolve ->(obj, _args, _ctx) { FindLoader.for(RecordBook).load obj.record_book_id }
    end
    field :team, TeamType do
      resolve ->(obj, _args, _ctx) { FindLoader.for(Team).load obj.team_id }
    end
    field :user, !UserType do
      resolve ->(obj, _args, _ctx) { FindLoader.for(User).load obj.user_id }
    end

    ## Has many associations
    field :completions, types[!CompletionType] do
      resolve ->(obj, _args, _ctx) { ForeignKeyLoader.for(Completion, :participation_id).load([obj.id]) }
    end
  end
end
