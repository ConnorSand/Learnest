class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_one_attached :photo

  validates :user, presence: true
  validates :content, length: { maximum: 100 }
end
