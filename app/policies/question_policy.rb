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

  def create?
    user.present?
  end

  def update?
    record.user == user
  end

  def upvote?
    user.present?
  end

  def downvote?
    user.present?
  end
end
