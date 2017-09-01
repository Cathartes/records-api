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
        param :start_time, :date_time, 'Start time of the first set of challenges'
        param :end_time, :date_time, 'End time for challenges to be completed'
        param :rush_start_time, :date_time, 'Start time of rush week'
        param :rush_end_time, :date_time, 'End time of rush week'
        param :time_zone, String, 'Time zone dates are sent using'
      end
    end

    doc_for :create do
      api! 'Create a single record book'
      authentication_headers
      param_group :record_book_params
    end

    doc_for :destroy do
      api! 'Destroy a single record book'
      authentication_headers
    end

    doc_for :index do
      api! 'Get a list of record books'
    end

    doc_for :show do
      api! 'Get a single record book'
    end

    doc_for :update do
      api! 'Update a single record book'
      authentication_headers
      param_group :record_book_params
    end
  end
end
