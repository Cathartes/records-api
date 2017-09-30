module V1
  class ParticipationSerializer < ApplicationSerializer
    belongs_to :record_book
    belongs_to :team
    belongs_to :user

    attributes :total_points
  end
end
