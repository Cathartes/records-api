# frozen_string_literal: true

module Mutations
  module Update
    class Participation < ::Mutations::Update::Base
      argument :id, !types.Int, 'ID of the participation to update'
      argument :teamId, types.Int, 'ID of a team to switch the participant to', as: :team_id

      description 'Update a single participation'
      type ::Types::ParticipationType

      def call(_obj, args, ctx)
        participation = ::Participation.find args[:id]
        update_generic participation, args, ctx
      end
    end
  end
end
