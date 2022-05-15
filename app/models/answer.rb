class Answer < ApplicationRecord
  acts_as_votable

  belongs_to :user
  belongs_to :question
  has_one_attached :photo

  validates :user, presence: true
  validates :question, presence: true
  validates :content, length: { maximum: 400 }
end
