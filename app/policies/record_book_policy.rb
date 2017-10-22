class RecordBookPolicy < ApplicationPolicy
  def create?
    user&.admin?
  end

  def destroy?
    user&.admin?
  end

  def index?
    true
  end

  def show?
    record.published? || user&.admin?
  end

  def update?
    user&.admin?
  end

  def permitted_attributes
    %i[end_time name published rush_end_time rush_start_time rush_week_active start_time]
  end

  class Scope < Scope
    def resolve
      user&.admin? ? scope.all : scope.published
    end
  end
end
