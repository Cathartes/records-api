# frozen_string_literal: true

module Mutations
  class Login < GraphQL::Function
    argument :email, !types.String, 'Email of the user logging in'
    argument :password, !types.String, 'Password for user authentication'

    description 'Login given a successful email and password'
    type ::Types::LoginType

    def call(_obj, args, _ctx)
      user = User.find_by! email: args[:email]
      return OpenStruct.new token: nil, uid: nil, user: user unless user.authenticate args[:password]

      token = user.authentication_tokens.create!

      OpenStruct.new token: token.body, uid: user.email, user: user
    end
  end
end
