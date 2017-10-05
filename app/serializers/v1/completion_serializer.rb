module V1
  class CompletionSerializer < ApplicationSerializer
    belongs_to :challenge
    belongs_to :participation

    attributes :points, :rank, :status
  end
end
