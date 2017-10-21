module Types
  module Enums
    DeleteMembershipTypeEnum = GraphQL::EnumType.define do
      name 'DeleteMembershipTypeEnum'

      value 'active', 'Indicates the user is active'
      value 'archived', 'Indicates that the user has participated and is not active'
      value 'deleted', 'Indicates that the user has no participations and is not active'
    end
  end
end
