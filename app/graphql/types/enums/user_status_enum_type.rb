module Types
  module Enums
    UserStatusEnumType = GraphQL::EnumType.define do
      name 'UserStatusEnumType'

      value 'active', 'Indicates the user is active'
      value 'archived', 'Indicates that the user has participated and is not active'
    end
  end
end
