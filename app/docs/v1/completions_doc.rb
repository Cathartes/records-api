module V1
  module CompletionsDoc
    extend Apipie::DSL::Concern
    extend ApplicationDoc

    namespace 'v1'
    resource :completions

    def_param_group :completion_params do
      json_api_wrap do
        param :challenge_id, Integer, 'ID of the challenge being completed', required: true, action_aware: true
        param :participation_id, Integer, 'ID of the participation completing this challenge', required: true, action_aware: true
        param :rank, Integer, 'Rank this participation achieved in this challenge', required: true, action_aware: true
        param :points, Integer, 'Custom points value (if different than the rank would normally give)',
              required: true, action_aware: true
      end
    end

    doc_for :create do
      api! 'Create a single completion'
      authentication_headers
      unprocessable_entity_error Completion
      param_group :completion_params
    end

    doc_for :destroy do
      api! 'Destroy a single completion'
      authentication_headers
      not_found_error Completion
    end

    doc_for :index do
      api! 'Get a list of completions'
      authentication_headers required: false
      param :participation_id, Integer, 'Participation ID to filter results by'
      param :user_id, Integer, 'User ID to filter results by'
    end

    doc_for :update do
      api! 'Update a single completion'
      authentication_headers
      not_found_error Completion
      unprocessable_entity_error Completion
      param_group :completion_params
    end
  end
end
