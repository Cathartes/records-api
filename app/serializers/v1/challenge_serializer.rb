module V1
  class ChallengeSerializer < ApplicationSerializer
    ## Foreign key attributes
    attributes :record_book_id

    ## Model attributes
    attributes :challenge_type, :name, :points, :repeatable

    belongs_to :record_book
  end
end
