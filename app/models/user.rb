class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_voter

  belongs_to :universities, optional: true
  has_many :questions
  has_many :answers
  has_many :notifications, as: :recipient
  has_one_attached :photo

  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :about_me, length: { maximum: 200 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
