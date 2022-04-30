class University < ApplicationRecord
  has_many :users, dependent: :destroy
  has_one_attached :photo

  validates :name, :country, :location, presence: true
  end
