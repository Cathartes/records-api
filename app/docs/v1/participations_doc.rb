module V1
  module ParticipationsDoc
    extend Apipie::DSL::Concern
    extend ApplicationDoc

    namespace 'v1'
    resource :participations

    def_param_group :participation_params do
      json_api_wrap do
        param :record_book_id, Integer,
              'ID of the record book this participation is a part of', required: true, action_aware: true
        param :team_id, Integer, 'ID of the team this participation is for', required: true, action_aware: true
        param :user_id, Integer, 'ID of the user participating in this record book', required: true, action_aware: true
        param :participation_type, ::Participation.participation_types.keys,
              'Type of participation', required: true, action_aware: true
      end
    end

    doc_for :create do
      api! 'Create a single participation'
      param_group :participation_params
    end

    doc_for :destroy do
      api! 'Destroy a single participation'
    end

    doc_for :index do
      api! 'Get a list of participations'
      param :record_book_id, Integer, 'Record book ID to filter results by'
      param :team_id, Integer, 'Team ID to filter results by'
      param :user_id, Integer, 'User ID to filter results by'
      param :participation_type, ::Participation.participation_types.keys, 'Participation type to filter results by'
    end

    doc_for :show do
      api! 'Get a single participation'
    end

    doc_for :update do
      api! 'Update a single participation'
      param_group :participation_params
    end
  end
end
