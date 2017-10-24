RecordsApiSchema = GraphQL::Schema.define do
  mutation Types::MutationType
  query Types::QueryType

  rescue_from Pundit::NotAuthorizedError, &:message

  resolve_type(lambda do |type, _obj, _ctx|
    case type
    when Challenge
      Types::ChallengeType
    when Completion
      Types::CompletionType
    when Moment
      Types::MomentType
    when Participation
      Types::ParticipationType
    when RecordBook
      Types::RecordBook
    when Team
      Types::TeamType
    when User
      Types::UserType
    else
      raise "GraphQL type of #{type.class.name} not implemented."
    end
  end)
end
