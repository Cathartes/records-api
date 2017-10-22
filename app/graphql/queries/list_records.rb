module Queries
  class ListRecords < GraphQL::Function
    def call(_obj, _args, ctx)
      ctx[:pundit].authorize model_name.constantize, :index?
      yield
    rescue Pundit::NotAuthorizedError => error
      GraphQL::ExecutionError.new error.message
    end

    def model_name
      self.class.name.split('List').last.singularize
    end
  end
end
