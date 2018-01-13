# frozen_string_literal: true

module Types
  module Enums
    UserMembershipTypeEnum = GraphQL::EnumType.define do
      name 'UserMembershipTypeEnum'

      value 'applicant', 'Indicates a user has not completed a record book yet'
      value 'member', 'Indicates a user is a full member of the clan'
      value 'retired', 'Indicates a user who has retired from active participation in record books'
    end
  end
end
