module Types
  QueryType = GraphQL::ObjectType.define do
    name 'Query'
    description 'Root query to fetch data'

    field :challenge, function: ::Queries::FindChallenge.new
    field :challenges, function: ::Queries::ListChallenges.new

    field :completion, function: ::Queries::FindCompletion.new
    field :completions, function: ::Queries::ListCompletions.new

    field :currentUser, function: ::Queries::CurrentUser.new

    field :moment, function: ::Queries::FindMoment.new
    field :moments, function: ::Queries::ListMoments.new

    field :participation, function: ::Queries::FindParticipation.new
    field :participations, function: ::Queries::ListParticipations.new

    field :recordBook, function: ::Queries::FindRecordBook.new
    field :recordBooks, function: ::Queries::ListRecordBooks.new

    field :team, function: ::Queries::FindTeam.new
    field :teams, function: ::Queries::ListTeams.new

    field :user, function: ::Queries::FindUser.new
    field :users, function: ::Queries::ListUsers.new
  end
end
