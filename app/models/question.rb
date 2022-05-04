class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_one_attached :photo

  validates :user, presence: true
  validates :content, length: { maximum: 100 }

  include PgSearch::Model
  pg_search_scope :global_search, against: [:content], associated_against: { answers: [:content] }, using: {
    tsearch: { prefix: true }
  }
end
