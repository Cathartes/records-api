module Types
  MutationType = GraphQL::ObjectType.define do
    name 'Mutation'
    description 'Root query to mutate data'

    field :login, function: Mutations::Login.new
  end
end
