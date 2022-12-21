class ExpenseController < ApplicationController
  def index
    @expenses = Group.find(params[:group_id]).expenses.order(created_at: :desc)
  end

  def new
    @expense = Expense.new
  end
  
  def create
    group = Group.find(params[:group_id])
    expense = Expense.new(expense_params)
    expense.user = current_user
    flash[:message] = if expense.save then
      group.expenses << expense
      "Expense created sucessfully"
    else
      "Expense could not be created"
    end
    redirect_to group_expense_index_path(params[:group_id])
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount)
  end
end