module Types
  module Enums
    MomentMomentTypeEnum = GraphQL::EnumType.define do
      name 'MomentMomentType'
      description 'List of valid moment types'

      value 'new_member', 'Indicates a user gained membership status'
      value 'completion', 'Indicates a user has completed a challenge'
    end
  end
end
