RecordsApiSchema = GraphQL::Schema.define do
  mutation Types::MutationType
  query Types::QueryType

  resolve_type(lambda do |obj, _ctx|
    case obj
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
      raise "GraphQL type of #{obj.class.name} not implemented."
    end
  end)
end
