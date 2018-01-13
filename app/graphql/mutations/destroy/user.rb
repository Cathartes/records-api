# frozen_string_literal: true

module Mutations
  module Destroy
    class User < ::Mutations::Destroy::Base
      argument :id, !types.Int, 'ID of the user getting updated or deleted'

      description 'Update a member status'
      type ::Types::UserType

      def call(_obj, args, ctx)
        user = ::User.find args[:id]
        destroy_generic user, ctx
      end
    end
  end
end
