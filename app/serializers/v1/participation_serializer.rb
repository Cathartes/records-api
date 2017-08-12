module V1
  class ParticipationSerializer < ApplicationSerializer
    attributes :participation_type

    belongs_to :record_book
    belongs_to :team
    belongs_to :user
  end
end
