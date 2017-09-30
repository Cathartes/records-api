module V1
  module MomentsDoc
    extend Apipie::DSL::Concern
    extend ApplicationDoc

    namespace 'v1'
    resource :moments

    doc_for :index do
      api! 'Get a list of moments'
      authentication_headers required: false
      param :record_book_id, Integer, 'Record book ID to filter results by'
      pagination_params
    end
  end
end
