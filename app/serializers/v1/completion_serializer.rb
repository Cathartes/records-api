module V1
  class CompletionSerializer < ApplicationSerializer
    attributes :points, :rank

    belongs_to :challenge
    belongs_to :participation
  end
end
