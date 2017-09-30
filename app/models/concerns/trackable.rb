module Trackable
  extend ActiveSupport::Concern

  included do
    has_one :moment, as: :trackable, dependent: :destroy

    before_validation :on_create_moment, on: :create
    before_validation :on_update_moment, on: :update
  end

  private

  def on_create_moment; end

  def on_update_moment; end
end
