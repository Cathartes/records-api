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

    field :updateChallenge, function: ::Mutations::UpdateChallenge.new
    field :updateCompletion, function: ::Mutations::UpdateCompletion.new
    field :updateRecordBook, function: ::Mutations::UpdateRecordBook.new
    field :updateUser, function: ::Mutations::UpdateUser.new
  end
end
