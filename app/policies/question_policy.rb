class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user_id: user.try(:id))
    end
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def update?
    owner? || admin?
  end

  private

  def owner?
    record.user == user
  end

  def admin?
    user.admin
  end
end
