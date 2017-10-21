module Queries
  class ListTeams < GraphQL::Function
    description 'List teams with various filters'
    type types[::Types::TeamType]

    def call(_obj, _args, ctx)
      ctx[:pundit].policy_scope Team.all
    end
  end
end
