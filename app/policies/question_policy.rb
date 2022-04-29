class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def edit?
    user.present? && (owner? || admin?)
  end

  def update?
    user.present? && (owner? || admin?)
  end

  private

  def owner?
    record.user == user
  end

  def admin?
    user.admin
  end
end
