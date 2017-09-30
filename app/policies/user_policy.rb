class UserPolicy < ApplicationPolicy
  def create?
    user&.admin?
  end

  def index?
    true
  end

  def update?
    user&.admin? || record == user
  end

  def permitted_attributes
    attrs = %i[discord_name email membership_type password]
    attrs << :admin if user&.admin?
    attrs
  end
end
