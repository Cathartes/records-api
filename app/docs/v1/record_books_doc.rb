module V1
  module RecordBooksDoc
    extend Apipie::DSL::Concern
    extend ApplicationDoc

    namespace 'v1'
    resource :record_books

    def_param_group :record_book_params do
      json_api_wrap do
        param :name, String, 'Name of the record book', required: true, action_aware: true
        param :published, :boolean, 'Whether the Record Book is publically visible'
        param :start_time, :date_time, 'Start time of the first set of challenges', allow_nil: true
        param :end_time, :date_time, 'End time for challenges to be completed', allow_nil: true
        param :rush_start_time, :date_time, 'Start time of rush week', allow_nil: true
        param :rush_end_time, :date_time, 'End time of rush week', allow_nil: true
      end
    end

    doc_for :create do
      api! 'Create a single record book'
      authentication_headers
      not_found_error RecordBook
      unprocessable_entity_error RecordBook
      param_group :record_book_params
    end

    doc_for :destroy do
      api! 'Destroy a single record book'
      authentication_headers
      not_found_error RecordBook
    end

    doc_for :index do
      api! 'Get a list of record books'
      pagination_params
    end

    doc_for :show do
      api! 'Get a single record book'
      not_found_error RecordBook
    end

    doc_for :update do
      api! 'Update a single record book'
      authentication_headers
      not_found_error RecordBook
      unprocessable_entity_error RecordBook
      param_group :record_book_params
    end
  end
end
