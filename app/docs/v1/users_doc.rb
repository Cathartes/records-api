module V1
  module UsersDoc
    extend Apipie::DSL::Concern
    extend ApplicationDoc

    namespace 'v1'
    resource :users

    def_param_group :user_params do
      json_api_wrap do
        param :discord_name, String, 'Discord name associated with the user', required: true, action_aware: true
        param :email, String, 'Unique email required for user login'
        param :password, String, 'Password required for user login'
      end
    end

    doc_for :create do
      api! 'Create a single user'
      param_group :user_params
    end

    doc_for :update do
      api! 'Update a single user'
      param_group :user_params
    end
  end
end
