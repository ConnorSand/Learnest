class University < ApplicationRecord
  has_many :users, dependent: :destroy

  validates :name, :country, :location,  uniqueness: true, presence: true
  end
