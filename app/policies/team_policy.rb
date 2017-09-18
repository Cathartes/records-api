class TeamPolicy < ApplicationPolicy
  def create?
    user&.admin?
  end

  def destroy?
    user&.admin? && record.participations.empty?
  end

  def index?
    true
  end

  def show?
    true
  end

  def update?
    user&.admin? && record.participations.empty?
  end

  def permitted_attributes
    %i[name]
  end
end
