module Types
  module Queries
    class FindBase < GraphQL::Function
      def self.human_model_name
        model_name.underscore.humanize.downcase
      end

      def self.model_name
        name.split('Find').last
      end

      argument :id, !types.ID, "ID of the #{human_model_name} to find"
      description "Find a single #{human_model_name} given an ID"

      def call(_obj, args, _ctx)
        self.class.model_name.constantize.find args[:id]
      rescue ActiveRecord::RecordNotFound => error
        GraphQL::ExecutionError.new error.message
      end
    end
  end
end
