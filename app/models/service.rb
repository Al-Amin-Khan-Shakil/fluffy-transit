class Service < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :name, :description, :image, presence: true
  validates :min_cost, presence: true, numericality: { greater_than: 0 }
end
