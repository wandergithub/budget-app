class AddIncomeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :income, :integer
  end
end
