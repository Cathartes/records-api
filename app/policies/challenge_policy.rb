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
    attrs = %i[challenge_type name points_completion points_first points_second points_third position]
    attrs += %i[record_book_id] unless record.persisted?
    attrs
  end

  class Scope < Scope
    def resolve
      user&.admin? ? scope.all : scope.published
    end
  end
end
