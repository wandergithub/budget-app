require 'rails_helper'

RSpec.describe 'Expense functionality integration tests', type: :feature do
  
   # New user
  let(:user) { User.create(name: "example 1", password: "pasword11212", email: "email@exmaple.com") }
  before(:each) do
    # Log in
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
  end
  describe 'Expense/transaction page' do
    before(:each) do
      @group = Group.create(name: "group example", user:)
      @expense = Expense.create(name: "expense example", amount: 9, user:)
      @group.expenses << @expense
      visit group_expense_index_path(@group.id)
    end
   
    it 'can visit expense page' do
      expect(page).to have_current_path(group_expense_index_path(@group.id))
    end

    it 'can see group expenses name' do
      expect(page).to have_content(@expense.name)
    end

    it 'Can visit new expense form' do
      click_on 'Add new expense'
      expect(page).to have_current_path(new_group_expense_path(@group.id))
    end

    describe 'Create new expense' do
      before(:each) do
        visit new_group_expense_path(@group.id)
      end
      it 'can see new expense form fields' do
        expect(page).to have_field('expense_name')
        expect(page).to have_field('expense_amount')
      end

      it 'Creates a new expense' do
        expect(Expense.where(name: "testing")).to_not exist
        
        fill_in 'expense_name', with: "testing"
        fill_in 'expense_amount', with: "3"
        
        click_on 'Save'
        expect(Expense.where(name: "testing")).to exist
      end
    end
  end

end