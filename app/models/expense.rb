class Expense < ApplicationRecord
  belongs_to :user

  has_many :group_expenses
  has_many :groups, through: :group_expenses

  validates :name, presence: true
  validates :amount, comparison: { greater_than_or_equal_to: 0 }
end
