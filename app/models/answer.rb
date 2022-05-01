class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_one_attached :photo

  validates :user, presence: true
  validates :question, presence: true
  validates :content, length: { maximum: 400 }
end
