# frozen_string_literal: true

module Mutations
  module Create
    class User < ::Mutations::Create::Base
      argument :discordName, !types.String, 'Discord name associated with the user', as: :discord_name
      argument :email, types.String, 'Unique email required for user login'
      argument :password, types.String, 'Password required for user login'
      argument :membershipType, Types::Enums::UserMembershipTypeEnum, 'Type of member this user is', as: :membership_type

      description 'Create a single user'
      type ::Types::UserType

      def call(_obj, args, ctx)
        create_generic ::User.new, args, ctx
      end
    end
  end
end
