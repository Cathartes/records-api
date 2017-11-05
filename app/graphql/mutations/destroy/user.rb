module Mutations
  module Destroy
    class User < ::Mutations::Destroy::Base
      argument :id, !types.Int, 'ID of the user getting updated or deleted'

      description 'Update a member status'
      type ::Types::UserType

      def call(_, args, ctx)
        user = ::User.find args[:id]
        destroy_generic user, args, ctx if user.participations.empty?
        raise Pundit::NotAuthorizedError, "Can't remove someone that have participated!"
      end
    end
  end
end
