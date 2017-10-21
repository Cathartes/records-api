module Types
  MutationType = GraphQL::ObjectType.define do
    name 'Mutation'
    description 'Root query to mutate data'

    field :createChallenge, function: ::Mutations::CreateChallenge.new
    field :createCompletion, function: ::Mutations::CreateCompletion.new
    field :createParticipation, function: ::Mutations::CreateParticipation.new
    field :createRecordBook, function: ::Mutations::CreateRecordBook.new
    field :createUser, function: ::Mutations::CreateUser.new

    field :login, function: ::Mutations::Login.new

    field :updateChallenge, function: ::Mutations::UpdateChallenge.new
    field :updateRecordBook, function: ::Mutations::UpdateRecordBook.new
    field :updateUser, function: ::Mutations::UpdateUser.new
  end
end
