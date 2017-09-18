module V1
  class RecordBookSerializer < ApplicationSerializer
    attributes :end_time, :name, :published, :rush_end_time, :rush_start_time, :start_time, :time_zone

    attributes :team_status

    def team_status
      object.teams.map do |team|
        {
          team_id:      team.id,
          team_name:    team.name,
          total_points: team.total_points_for_record_book(object)
        }
      end
    end
  end
end
