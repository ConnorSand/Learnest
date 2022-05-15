class AnswerPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user_id: user.try(:id))
    end
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
