class Question < ApplicationRecord
  # acts_as_taggable_on :tags
  acts_as_votable

  belongs_to :user
  has_many :answers
  has_many :notifications, as: :recipient, dependent: :destroy
  has_one_attached :photo
  has_many :taggings
  has_many :tags, through: :taggings

  validates :user, presence: true
  validates :title, presence: true, length: { maximum: 300 }
  validates :content, length: { maximum: 10_000 }

  def self.tagged_with(name)
    Tag.find_by!(name: name).posts
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  include PgSearch::Model
  pg_search_scope :global_search, against: [:content], associated_against: { answers: [:content] }, using: {
    tsearch: { prefix: true }
  }

  # QuestionNotification.with(question: @question).deliver(user)
  # @question.notifications_as_question
end
