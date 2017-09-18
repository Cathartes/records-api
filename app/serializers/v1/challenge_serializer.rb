module V1
  class ChallengeSerializer < ApplicationSerializer
    belongs_to :record_book

    attributes :max_completions, :name, :points
  end
end
