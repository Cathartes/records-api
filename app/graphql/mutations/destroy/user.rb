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
          user = nil
        else
          record.update(status: 1)
          save_attributes record, args, ctx, type: :update?
        end
        user
      end
    end
  end
end
