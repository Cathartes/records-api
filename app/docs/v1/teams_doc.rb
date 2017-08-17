module V1
  module TeamsDoc
    extend Apipie::DSL::Concern
    extend ApplicationDoc

    namespace 'v1'
    resource :teams

    def_param_group :team_params do
      json_api_wrap do
        param :name, String, 'Name of the team', required: true, action_aware: true
      end
    end

    doc_for :create do
      api! 'Create a single team'
      param_group :team_params
    end

    doc_for :destroy do
      api! 'Destroy a single team'
    end

    doc_for :index do
      api! 'Get a list of teams'
    end

    doc_for :show do
      api! 'Get a single team'
    end

    doc_for :update do
      api! 'Update a single team'
      param_group :team_params
    end
  end
end
