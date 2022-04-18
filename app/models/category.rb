class Category < ApplicationRecord
  has_many :expenses

  validates :category_name, presence: true, uniqueness: true 
end
