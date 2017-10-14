module Types
  RecordBookType = GraphQL::ObjectType.define do
    name 'RecordBook'
    description 'A collection of challenges in a given month'

    interfaces [Interfaces::ModelInterface]

    ## Attributes stored in the DB
    field :name, !types.String
    field :published, !types.Boolean
    field :startTime, types.String, property: :start_time
    field :endTime, types.String, property: :end_time
    field :rushStartTime, types.String, property: :rush_start_time
    field :rushEndTime, types.String, property: :rush_end_time

    ## Has many associations
    field :challenges, types[!ChallengeType]
    field :participations, types[!ParticipationType]
    field :teams, types[!TeamType]
  end
end
