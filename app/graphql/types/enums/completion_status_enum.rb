# frozen_string_literal: true

module Types
  module Enums
    CompletionStatusEnum = GraphQL::EnumType.define do
      name 'CompletionStatus'

      value 'pending', 'Indicates a completion needs to be verified by an admin'
      value 'approved', 'Indicates a completion has been verified'
      value 'declined', 'Indicates a completion has not been accepted and will not be added for points'
    end
  end
end
