module Mutations
  module Destroy
    class User < GraphQL::Function
      argument :id, !types.Int, 'ID of the member getting updated'

      description 'Update a member status'
      type ::Types::UserType

      def call(_, args)
        @user = User.find args[:id]
        if @user.participations.empty?
          @user.destroy
        else
          @user.update(current_user_status: 1)
        end
        @user
      end
    end
  end
end
