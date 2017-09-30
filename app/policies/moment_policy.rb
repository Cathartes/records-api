class MomentPolicy < ApplicationPolicy
  def index?
    true
  end

  class Scope < Scope
    def resolve
      user&.admin? ? scope.all : scope.for_user(user)
    end
  end
end
