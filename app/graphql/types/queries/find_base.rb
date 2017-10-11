module Types
  module Queries
    class FindBase < GraphQL::Function
      def self.human_klass_name
        name.split('Find').last.underscore.humanize.downcase
      end

      argument :id, !types.ID, "ID of the #{human_klass_name} to find"
      description "Find a single #{human_klass_name} given an ID"

      def call(_obj, args, _ctx)
        @klass.find args[:id]
      rescue ActiveRecord::RecordNotFound => error
        GraphQL::ExecutionError.new error.message
      end
    end
  end
end
