class Food < ApplicationRecord
  # setup relationship b/w food and user
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :recipe, through: :recipe_foods
  validates :name, presence: true, length: { in: 3..32 }
  validates :unit, presence: true, length: { in: 1..20 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
