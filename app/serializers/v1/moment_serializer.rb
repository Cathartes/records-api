module V1
  class MomentSerializer < ApplicationSerializer
    belongs_to :record_book

    has_one :trackable, polymorphic: true

    attributes :moment_type
  end
end
