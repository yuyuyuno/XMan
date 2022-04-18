class Expense < ApplicationRecord
    belongs_to :user
    belongs_to :category

    validates :amount, presence: true, numericality: {greater_than: 0}
end
