module V1
  class MomentSerializer < ApplicationSerializer
    belongs_to :record_book
    belongs_to :trackable, polymorphic: true

    attributes :moment_type
  end
end
