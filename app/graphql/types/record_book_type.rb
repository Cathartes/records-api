module Types
  RecordBookType = GraphQL::ObjectType.define do
    name 'RecordBook'
    description 'A collection of challenges in a given month'

    interfaces [Interfaces::ModelInterface]

    ## Attributes stored in the DB
    field :name, !types.String
    field :published, !types.Boolean
    field :startTime, types.String do
      resolve ->(obj, _args, _ctx) { obj.start_time.iso8601 }
    end
    field :endTime, types.String do
      resolve ->(obj, _args, _ctx) { obj.end_time.iso8601 }
    end
    field :rushStartTime, types.String do
      resolve ->(obj, _args, _ctx) { obj.rush_start_time.iso8601 }
    end
    field :rushEndTime, types.String do
      resolve ->(obj, _args, _ctx) { obj.rush_end_time.iso8601 }
    end

    ## Has many associations
    field :challenges, types[!ChallengeType]
    field :participations, types[!ParticipationType]
    field :teams, types[!TeamType]
  end
end
