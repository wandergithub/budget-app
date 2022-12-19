class Expense < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true
  validates :amount, comparison: { greater_than_or_equal_to: 0 }
end