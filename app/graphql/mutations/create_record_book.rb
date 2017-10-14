module Mutations
  RecordBookInputType = GraphQL::InputObjectType.define do
    name 'RecordBookInputType'
    description 'Attributes for creating a record book'

    argument :name, !types.String, 'Name of the record book'
    argument :published, types.Boolean, 'Whether the Record Book is publically visible'
    argument :startTime, types.String, 'Start time of the first set of challenges', as: :start_time
    argument :endTime, types.String, 'End time for challenges to be completed', as: :end_time
    argument :rushStartTime, types.String, 'Start time of rush week', as: :rush_start_time
    argument :rushEndTime, types.String, 'End time of rush week', as: :rush_end_time
  end

  class CreateRecordBook < GraphQL::Function
    argument :recordBook, RecordBookInputType

    description 'Create a single record book'
    type ::Types::RecordBookType

    def call(_obj, args, ctx)
      @record_book = RecordBook.new
      @record_book.assign_attributes record_book_args args[:recordBook], ctx
      @record_book.save
      @record_book
    end

    def record_book_args(args, ctx)
      attrs = Pundit.policy(ctx[:current_user], @record_book).permitted_attributes
      args.to_h.select { |k, _v| attrs.include? k.to_sym }
    end
  end
end
