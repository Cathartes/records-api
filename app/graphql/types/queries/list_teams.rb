module Types
  module Queries
    class ListTeams < GraphQL::Function
      description 'List teams with various filters'
      type types[::Types::TeamType]

      def call(_obj, _args, _ctx)
        Team.all
      end
    end
  end
end
