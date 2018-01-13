# frozen_string_literal: true

module Queries
  module List
    class Base < GraphQL::Function
      def call(_obj, _args, ctx)
        ctx[:pundit].authorize model_name.constantize, :index?
        yield
      end

      def model_name
        self.class.name.split('List').last.singularize
      end
    end
  end
end
