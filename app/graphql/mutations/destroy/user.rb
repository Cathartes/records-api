module Mutations
  module Destroy
    class User < ::Mutations::Destroy::Base
      argument :id, !types.Int, 'ID of the user getting updated or deleted'

      description 'Update a member status'
      type ::Types::UserType

      def call(_, args, ctx)
        user = ::User.find args[:id]
        if user.participations.empty?
          destroy_generic user, args, ctx
        else
          update_status_generic user, args, ctx
        end
        user
      end
    end
  end
end
