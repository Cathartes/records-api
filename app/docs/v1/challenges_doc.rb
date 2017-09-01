module V1
  module ChallengesDoc
    extend Apipie::DSL::Concern
    extend ApplicationDoc

    namespace 'v1'
    resource :challenges

    def_param_group :challenge_params do
      json_api_wrap do
        param :record_book_id, Integer, 'ID of the record book this challenge is a part of', required: true, action_aware: true
        param :name, String, 'Name of the challenge', required: true, action_aware: true
        param :max_completions, Integer,
              'Max number of times this challenge can be completed (0 is infinite)', required: true, action_aware: true
        param :points, Array, 'Array of rank-points key-value pairs', of: Hash
      end
    end

    doc_for :create do
      api! 'Create a single challenge'
      authentication_headers
      param_group :challenge_params
    end

    doc_for :destroy do
      api! 'Destroy a single challenge'
      authentication_headers
    end

    doc_for :index do
      api! 'Get a list of challenges'
      authentication_headers required: false
      param :record_book_id, Integer, 'Record book ID to filter results by'
    end

    doc_for :show do
      api! 'Get a single challenge'
    end

    doc_for :update do
      api! 'Update a single challenge'
      authentication_headers
      param_group :challenge_params
    end
  end
end
