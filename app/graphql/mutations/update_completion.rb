module Mutations
  class UpdateCompletion < GraphQL::Function
    argument :id, !types.ID, 'ID of the record book to update'
    argument :points, types.Int, 'Override the number of points given'
    argument :rank, types.Int, 'Override rank to assign points to this completion'
    argument :status, ::Types::Enums::CompletionStatusEnum, 'Status this completion is in'

    description 'Update a single completion'
    type ::Types::CompletionType

    def call(_obj, args, ctx)
      @completion = Completion.find args[:id]
      @completion.update_attributes completion_args args, ctx
      @completion
    end

    def completion_args(args, ctx)
      attrs = Pundit.policy(ctx[:current_user], @completion).permitted_attributes
      args.to_h.select { |k, _v| attrs.include? k.to_sym }
    end
  end
end
