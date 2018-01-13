# frozen_string_literal: true

module Types
  RecordBookType = GraphQL::ObjectType.define do
    name 'RecordBook'
    description 'A collection of challenges in a given month'

    interfaces [Interfaces::ModelInterface]

    ## Attributes stored in the DB
    field :name, !types.String
    field :published, !types.Boolean
    field :rushWeekActive, !types.Boolean, property: :rush_week_active
    field :startTime, types.String do
      resolve ->(obj, _args, _ctx) { obj.start_time&.iso8601 }
    end
    field :endTime, types.String do
      resolve ->(obj, _args, _ctx) { obj.end_time&.iso8601 }
    end
    field :rushStartTime, types.String do
      resolve ->(obj, _args, _ctx) { obj.rush_start_time&.iso8601 }
    end
    field :rushEndTime, types.String do
      resolve ->(obj, _args, _ctx) { obj.rush_end_time&.iso8601 }
    end

    ## Has many associations
    field :challenges, types[!ChallengeType] do
      resolve ->(obj, _args, _ctx) { ForeignKeyLoader.for(Challenge, :record_book_id).load([obj.id]) }
    end
    field :participations, types[!ParticipationType] do
      resolve ->(obj, _args, _ctx) { ForeignKeyLoader.for(Participation, :record_book_id).load([obj.id]) }
    end
    field :teams, types[!TeamType] do
      resolve(lambda do |obj, _args, _ctx|
        ForeignKeyLoader.for(Participation, :record_book_id).load([obj.id]).then do |participations|
          ForeignKeyLoader.for(Team, :id).load(participations.map(&:team_id))
        end
      end)
    end
  end
end
