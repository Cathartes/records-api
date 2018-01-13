# frozen_string_literal: true

module Mutations
  module Update
    class Completion < ::Mutations::Update::Base
      argument :id, !types.Int, 'ID of the completion to update'
      argument :points, types.Int, 'Override the number of points given'
      argument :rank, types.Int, 'Override rank to assign points to this completion'
      argument :status, ::Types::Enums::CompletionStatusEnum, 'Status this completion is in'

      description 'Update a single completion'
      type ::Types::CompletionType

      def call(_obj, args, ctx)
        completion = ::Completion.find args[:id]
        update_generic completion, args, ctx
      end
    end
  end
end
