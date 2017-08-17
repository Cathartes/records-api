module V1
  class ChallengeSerializer < ApplicationSerializer
    attributes :max_completions, :name, :points

    belongs_to :record_book
  end
end
