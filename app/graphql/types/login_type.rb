# frozen_string_literal: true

module Types
  LoginType = GraphQL::ObjectType.define do
    name 'Login'
    description 'Login return including a token and user'

    field :token, types.String
    field :uid, types.String
    field :user, UserType
  end
end
