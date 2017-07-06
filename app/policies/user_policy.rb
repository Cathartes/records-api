class UserPolicy < ApplicationPolicy
  def create?
    user&.admin?
  end

  def update?
    user&.admin? || record == user
  end

  def permitted_attributes
    attrs = %i[discord_name email password]
    attrs << :admin if user&.admin?
    attrs
  end
end
