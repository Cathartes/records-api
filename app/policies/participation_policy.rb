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
    %i[participation_type record_book_id team_id user_id]
  end
end
