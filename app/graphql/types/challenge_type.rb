module Types
  ChallengeType = GraphQL::ObjectType.define do
    name 'Challenge'
    description 'An individual challenge within a record book'

    interfaces [Interfaces::ModelInterface]

    ## Attributes stored in the DB
    field :name, !types.String
    field :pointsFirst, types.Int, property: :points_first
    field :pointsSecond, types.Int, property: :points_second
    field :pointsThird, types.Int, property: :points_third
    field :pointsCompletion, !types.Int, property: :points_completion
    field :maxCompletions, !types.Int, property: :max_completions

    ## Belongs to associations
    field :recordBook, !RecordBookType, property: :record_book
  end
end
