module Queries
  class FindRecord < GraphQL::Function
    def initialize(model)
      @model = model

      self.class.description "Find a single #{human_model_name(model)} given an ID"
      self.class.type "::Types::#{model.name}Type".constantize

      self.class.argument :id, !GraphQL::INT_TYPE, "ID of the #{human_model_name(model)} to find"
    end

    def human_model_name(model)
      model.name.underscore.humanize.downcase
    end

    def call(_obj, args, ctx)
      record = @model.find args[:id]
      ctx[:pundit].authorize record, :show?
      record
    rescue ActiveRecord::RecordNotFound, Pundit::NotAuthorizedError => error
      GraphQL::ExecutionError.new error.message
    end
  end
end
