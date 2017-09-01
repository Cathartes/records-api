module V1
  module SessionsDoc
    extend Apipie::DSL::Concern
    extend ApplicationDoc

    namespace 'v1'
    resource :sessions

    doc_for :create do
      api! 'Create a single session'
      json_api_wrap do
        param :email, String, 'Unique login email', required: true
        param :password, String, 'Login password for authentication', required: true
      end
    end

    doc_for :destroy do
      api! 'Destroy a single session'
    end

    doc_for :show do
      api! 'Retrieve the currently signed in user'
    end
  end
end
