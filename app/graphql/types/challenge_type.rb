module Types
  ChallengeType = GraphQL::ObjectType.define do
    name 'Challenge'
    description 'An individual challenge within a record book'

    interfaces [Interfaces::ModelInterface]

    ## Attributes stored in the DB
    field :name, !types.String
    field :maxCompletions, !types.Int, property: :max_completions
    field :pointsCompletion, !types.Int, property: :points_completion
    field :pointsFirst, types.Int, property: :points_first
    field :pointsSecond, types.Int, property: :points_second
    field :pointsThird, types.Int, property: :points_third
    field :position, !types.Int

    ## Belongs to associations
    field :recordBook, !RecordBookType, property: :record_book

    ## Has many associations
    field :completions, types[!CompletionType]

    ## Custom attributes
    field :completionsCount, !types.Int do
      resolve(lambda do |obj, _args, _ctx|
        obj.completions.size
      end)
    end
  end
end
