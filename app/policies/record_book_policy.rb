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
    %i[end_time name published rush_end_time rush_start_time start_time time_zone]
  end
end
