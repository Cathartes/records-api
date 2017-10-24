module Types
  module Enums
    ParticipationMembershipTypeEnum = GraphQL::EnumType.define do
      name 'ParticipationMembershipTypeEnum'

      value 'applicant', 'Indicates a user is participating in their first record book'
      value 'member', 'Indicates a user was a full member during this record book'
    end
  end
end
