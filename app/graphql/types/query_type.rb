# frozen_string_literal: true

module Types
  QueryType = GraphQL::ObjectType.define do
    name 'Query'
    description 'Root query to fetch data'

    field :challenge, function: ::Queries::FindRecord.new(Challenge)
    field :challenges, function: ::Queries::List::Challenges.new

    field :completion, function: ::Queries::FindRecord.new(Completion)
    field :completions, function: ::Queries::List::Completions.new

    field :currentUser, function: ::Queries::CurrentUser.new

    field :participation, function: ::Queries::FindRecord.new(Participation)
    field :participations, function: ::Queries::List::Participations.new

    field :recordBook, function: ::Queries::FindRecord.new(RecordBook)
    field :recordBooks, function: ::Queries::List::RecordBooks.new

    field :team, function: ::Queries::FindRecord.new(Team)
    field :teams, function: ::Queries::List::Teams.new

    field :user, function: ::Queries::FindRecord.new(User)
    field :users, function: ::Queries::List::Users.new
  end
end
