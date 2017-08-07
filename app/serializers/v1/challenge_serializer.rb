module V1
  class ChallengeSerializer < ApplicationSerializer
    attributes :challenge_type, :name, :points, :repeatable

    belongs_to :record_book
  end
end
