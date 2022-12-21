require 'rails_helper'

RSpec.describe 'Expense functionality integration tests', type: :feature do
  describe 'Expense/transaction page' do
    it 'can visit expense page' do
      visit group_expenses_path
      expect(page).to have_current_path(group_expenses_path)
    end
  end
end