# frozen_string_literal: true

module Types
  module Enums
    ChallengeTypeEnum = GraphQL::EnumType.define do
      name 'ChallengeType'

      value 'all', 'Indicates a challenge can be completed by anyone'
      value 'applicant', 'Indicates a challenge can be completed by applicants only'
      value 'member', 'Indicates a challenge can be completed by members only'
    end
  end
end
