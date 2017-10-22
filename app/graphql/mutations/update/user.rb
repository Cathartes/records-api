module Mutations
  module Update
    class User < Base
      argument :id, !types.Int, 'ID of the user to update'
      argument :discordName, types.String, 'Discord name associated with the user', as: :discord_name
      argument :email, types.String, 'Unique email required for user login'
      argument :password, types.String, 'Password required for user login'
      argument :membershipType, Types::Enums::UserMembershipTypeEnum, 'Type of member this user is', as: :membership_type

      description 'Update a single user'
      type ::Types::UserType

      def call(_obj, args, ctx)
        user = User.find args[:id]
        update_generic user, args, ctx
      end
    end
  end
end
