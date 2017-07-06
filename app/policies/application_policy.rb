class ApplicationPolicy
  attr_reader :user, :record

  def create?
    false
  end

  def destroy?
    false
  end

  def initialize(user, record)
    @user   = user
    @record = record
  end

  def index?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  def show?
    false
  end

  def update?
    false
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
