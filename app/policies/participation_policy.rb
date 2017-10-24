class ParticipationPolicy < ApplicationPolicy
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
    user&.admin? || record.record_book&.published?
  end

  def update?
    user&.admin?
  end

  def permitted_attributes
    attrs = %i[team_id]
    attrs += %i[record_book_id user_id] unless record.persisted?
    attrs
  end
end
