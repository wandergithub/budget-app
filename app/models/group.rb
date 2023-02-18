class Group < ApplicationRecord
  # image field
  has_one_attached :image

  belongs_to :user

  has_many :group_expenses
  has_many :expenses, through: :group_expenses

  validates :name, presence: true

  def total_expenses
    expenses.sum(:amount)
  end
end
