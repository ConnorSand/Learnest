class Question < ApplicationRecord
  # acts_as_taggable_on :tags
  acts_as_votable

  belongs_to :user
  has_many :answers
  has_many :notifications, as: :recipient, dependent: :destroy
  has_one_attached :photo

  validates :user, presence: true
  validates :title, presence: true, length: { maximum: 300 }
  validates :content, length: { maximum: 10_000 }

  include PgSearch::Model
  pg_search_scope :global_search, against: [:content], associated_against: { answers: [:content] }, using: {
    tsearch: { prefix: true }
  }

  # QuestionNotification.with(question: @question).deliver(user)
  # @question.notifications_as_question
end
