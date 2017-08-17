class ChallengePolicy < ApplicationPolicy
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
    record.record_book&.published? || user&.admin?
  end

  def update?
    user&.admin?
  end

  def permitted_attributes
    %i[max_completions name record_book_id] + [points: {}]
  end

  class Scope < Scope
    def resolve
      user&.admin? ? scope.all : scope.published
    end
  end
end
