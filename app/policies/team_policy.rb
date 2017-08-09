class TeamPolicy < ApplicationPolicy
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
    true
  end

  def update?
    user&.admin?
  end

  def permitted_attributes
    %i[name]
  end
end
