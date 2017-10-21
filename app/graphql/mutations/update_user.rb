module Mutations
  class UpdateUser < GraphQL::Function
    argument :id, !types.Int, 'ID of the user to update'
    argument :discordName, types.String, 'Discord name associated with the user', as: :discord_name
    argument :email, types.String, 'Unique email required for user login'
    argument :password, types.String, 'Password required for user login'
    argument :membershipType, Types::Enums::UserMembershipTypeEnum, 'Type of member this user is', as: :membership_type

    description 'Update a single user'
    type ::Types::UserType

    def call(_obj, args, ctx)
      @user = User.find args[:id]
      @user.update_attributes user_args args, ctx
      @user
    end

    def user_args(args, ctx)
      attrs = Pundit.policy(ctx[:current_user], @user).permitted_attributes
      args.to_h.select { |k, _v| attrs.include? k.to_sym }
    end
  end
end
