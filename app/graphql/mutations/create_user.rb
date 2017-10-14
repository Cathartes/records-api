module Mutations
  UserInputType = GraphQL::InputObjectType.define do
    name 'UserInputType'
    description 'Attributes for creating a user'

    argument :discordName, !types.String, 'Discord name associated with the user', as: :discord_name
    argument :email, types.Boolean, 'Unique email required for user login'
    argument :password, types.String, 'Password required for user login'
    argument :membershipType, Types::Enums::UserMembershipTypeEnum, 'Type of member this user is'
  end

  class CreateUser < GraphQL::Function
    argument :user, UserInputType

    description 'Create a single user'
    type ::Types::UserType

    def call(_obj, args, ctx)
      @user = User.new
      @user.assign_attributes user_args args[:user], ctx
      @user.save
      @user
    end

    def user_args(args, ctx)
      attrs = Pundit.policy(ctx[:current_user], @user).permitted_attributes
      args.to_h.select { |k, _v| attrs.include? k.to_sym }
    end
  end
end
