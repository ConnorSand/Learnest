class Question < ApplicationRecord
  # acts_as_taggable_on :tags
  acts_as_votable

  belongs_to :user
  has_many :answers
  has_one_attached :photo

  validates :user, presence: true
  validates :title, presence: true, length: { maximum: 300 }
  validates :content, length: { maximum: 10_000 }

  include PgSearch::Model
  pg_search_scope :global_search, against: [:content], associated_against: { answers: [:content] }, using: {
    tsearch: { prefix: true }
  }
end
