module Types
  TeamType = GraphQL::ObjectType.define do
    name 'Team'
    description 'A group of users competing against other teams in a record book'

    interfaces [Interfaces::ModelInterface]

    ## Attributes stored in the DB
    field :name, !types.String

    ## Has many associations
    field :participations, types[!ParticipationType] do
      resolve ->(obj, _args, _ctx) { ForeignKeyLoader.for(Participation, :team_id).load([obj.id]) }
    end
  end
end
