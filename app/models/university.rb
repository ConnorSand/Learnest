class University < ApplicationRecord
  has_many :users, dependent: :destroy

  validates :name, :country, :location, presence: true

  end
