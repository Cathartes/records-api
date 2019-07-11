# frozen_string_literal: true

module Queries
  module List
    class Teams < ::Queries::List::Base
      description 'List teams with various filters'
      type !types[::Types::TeamType]

      def call(_obj, _args, ctx)
        super do
          ctx[:pundit].policy_scope ::Team.all
        end
      end
    end
  end
end
