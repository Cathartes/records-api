module Types
  module Interfaces
    ModelInterface = GraphQL::InterfaceType.define do
      name 'Model'

      field :id, !types.ID
      field :createdAt, !types.String do
        resolve ->(obj, _args, _ctx) { obj.created_at.iso8601 }
      end
      field :updatedAt, !types.String do
        resolve ->(obj, _args, _ctx) { obj.updated_at.iso8601 }
      end
    end
  end
end