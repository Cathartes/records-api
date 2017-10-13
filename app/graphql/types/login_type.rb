module Types
  LoginType = GraphQL::ObjectType.define do
    name 'Login'
    description 'Login return including a token and user'

    field :token, types.String
    field :uid, types.String
  end
end
