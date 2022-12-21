require 'rails_helper'

RSpec.describe 'Expense functionality integration tests', type: :feature do
  describe 'Expense/transaction page' do
    it 'can visit expense page' do
      visit group_expense_index_path
      expect(page).to have_current_path(group_expense_index_path)
    end
  end
end