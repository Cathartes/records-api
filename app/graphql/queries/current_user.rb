module Queries
  class CurrentUser < GraphQL::Function
    description 'Return the current user'
    type ::Types::UserType

    def call(_obj, _args, ctx)
      ctx[:current_user]
    end
  end
end
