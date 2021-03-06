# frozen_string_literal: true

module Types
  MutationType = GraphQL::ObjectType.define do
    name 'Mutation'
    description 'Root query to mutate data'

    field :createChallenge, function: ::Mutations::Create::Challenge.new
    field :createCompletion, function: ::Mutations::Create::Completion.new
    field :createParticipation, function: ::Mutations::Create::Participation.new
    field :createRecordBook, function: ::Mutations::Create::RecordBook.new
    field :createUser, function: ::Mutations::Create::User.new

    field :login, function: ::Mutations::Login.new

    field :updateChallenge, function: ::Mutations::Update::Challenge.new
    field :updateCompletion, function: ::Mutations::Update::Completion.new
    field :updateParticipation, function: ::Mutations::Update::Participation.new
    field :updateRecordBook, function: ::Mutations::Update::RecordBook.new
    field :updateUser, function: ::Mutations::Update::User.new

    field :destroyUser, function: ::Mutations::Destroy::User.new
  end
end
