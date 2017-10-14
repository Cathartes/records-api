module Types
  MutationType = GraphQL::ObjectType.define do
    name 'Mutation'
    description 'Root query to mutate data'

    field :createRecordBook, function: ::Mutations::CreateRecordBook.new
    field :createUser, function: ::Mutations::CreateUser.new

    field :login, function: ::Mutations::Login.new

    field :updateRecordBook, function: ::Mutations::UpdateRecordBook.new
  end
end
