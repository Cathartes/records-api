module Mutations
  class DeleteMember < GraphQL::Function
    argument :id, !types.ID, 'ID of the member getting updated'

    description 'Update a member status'
    type ::Types::UserType

    def call(_, args, ctx)
      @user = User.find args[:id]
      if @user.participations.length > 0
        @user.update(current_user_status: 1)
      else
        @user.update(current_user_status: 2)
      end
      @user
    end

    def delete_member_args(args, ctx)
      attrs = Pundit.policy(ctx[:current_user], @record_book).permitted_attributes
      args.to_h.select { |k, _v| attrs.include? k.to_sym }
    end
  end
end
