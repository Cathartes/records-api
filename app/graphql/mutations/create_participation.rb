module Mutations
  class CreateParticipation < GraphQL::Function
    argument :recordBookId, !types.ID, 'ID of a record book to add the participant to', as: :record_book_id
    argument :userId, !types.ID, 'ID of an existing user to add to the record book', as: :user_id
    argument :teamId, types.ID, 'ID of a team to add the participant to', as: :team_id

    description 'Create a single participation within a record book'
    type ::Types::ParticipationType

    def call(_obj, args, ctx)
      @participation = Participation.new
      @participation.assign_attributes participation_args args, ctx
      @participation.save
      @participation
    end

    def participation_args(args, ctx)
      attrs = Pundit.policy(ctx[:current_user], @participation).permitted_attributes
      args.to_h.select { |k, _v| attrs.include? k.to_sym }
    end
  end
end
