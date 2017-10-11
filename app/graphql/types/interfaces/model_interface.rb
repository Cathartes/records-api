module Types
  module Interfaces
    ModelInterface = GraphQL::InterfaceType.define do
      name 'Model'

      field :id, !types.ID
      field :createdAt, !types.String, property: :created_at
      field :updatedAt, !types.String, property: :updated_at
    end
  end
end
