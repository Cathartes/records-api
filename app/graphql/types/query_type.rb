module Types
  QueryType = GraphQL::ObjectType.define do
    name 'Query'
    description 'Root query to fetch data'

    field :challenge, function: ::Queries::FindRecord.new(Challenge)
    field :challenges, function: ::Queries::ListChallenges.new

    field :completion, function: ::Queries::FindRecord.new(Completion)
    field :completions, function: ::Queries::ListCompletions.new

    field :currentUser, function: ::Queries::CurrentUser.new

    field :participation, function: ::Queries::FindRecord.new(Participation)
    field :participations, function: ::Queries::ListParticipations.new

    field :recordBook, function: ::Queries::FindRecord.new(RecordBook)
    field :recordBooks, function: ::Queries::ListRecordBooks.new

    field :team, function: ::Queries::FindRecord.new(Team)
    field :teams, function: ::Queries::ListTeams.new

    field :user, function: ::Queries::FindRecord.new(User)
    field :users, function: ::Queries::ListUsers.new
  end
end
