module Types
  UserType = GraphQL::ObjectType.define do
    name 'User'
    description 'An account linked to a Discord user'

    interfaces [Interfaces::ModelInterface]

    ## Attributes stored in the DB
    field :email, types.String
    field :discordName, !types.String, property: :discord_name
    field :resetPasswordSentAt, types.String, property: :reset_password_sent_at
    field :confirmedAt, types.String, property: :confirmed_at
    field :confirmationSentAt, types.String, property: :confirmation_sent_at
    field :unconfirmedEmail, types.String, property: :unconfirmed_email
    field :admin, !types.Boolean
    field :passwordUpdatedAt, types.String, property: :password_updated_at
    field :membershipType, !Enums::UserMembershipTypeEnum, property: :membership_type

    ## Has many associations
    field :participations, types[!ParticipationType] do
      resolve ->(obj, _args, _ctx) { ForeignKeyLoader.for(Participation, :user_id).load([obj.id]) }
    end
  end
end
