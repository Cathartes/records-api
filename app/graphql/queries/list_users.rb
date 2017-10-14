module Queries
  class ListUsers < GraphQL::Function
    argument :membershipType, Types::Enums::UserMembershipTypeEnum, 'Type of user to filter results by', as: :membership_type

    description 'List users with various filters'
    type types[::Types::UserType]

    def call(_obj, args, _ctx)
      scope = User.all

      scope = case args[:membershipType]
              when 'applicant'
                scope.applicant
              when 'member'
                scope.member
              else
                scope
              end

      scope
    end
  end
end
