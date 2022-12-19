require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:user) { User.new(name: 'user 1') }

  context 'Expense model examples' do
    it 'is valid with right attributes' do
      expect(Expense.new(name: 'expense 1', user:)).to be_valid
    end

    it 'requires a name' do
      expect(Expense.new(user:)).to_not be_valid
    end
  end
end