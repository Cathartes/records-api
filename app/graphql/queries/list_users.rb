module Queries
  class ListUsers < ListRecords
    argument :membershipType, Types::Enums::UserMembershipTypeEnum, 'Type of user to filter results by', as: :membership_type

    description 'List users with various filters'
    type types[::Types::UserType]

    def call(_obj, args, ctx)
      super do
        scope = ctx[:pundit].policy_scope User.all

        scope = case args[:membership_type]
                when 'applicant'
                  scope.applicant
                when 'member'
                  scope.member
                when 'retired'
                  scope.retired
                else
                  scope
                end

        scope
      end
    end
  end
end
