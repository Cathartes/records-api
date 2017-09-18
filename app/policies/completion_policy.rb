class CompletionPolicy < ApplicationPolicy
  def create?
    user&.admin?
  end

  def destroy?
    user&.admin?
  end

  def index?
    user.present?
  end

  def update?
    user&.admin?
  end

  def permitted_attributes
    %i[challenge_id participation_id points rank]
  end

  class Scope < Scope
    def resolve
      user&.admin? ? scope.all : scope.for_user(user)
    end
  end
end
