class ExpenseController < ApplicationController
  before_action :authenticate_user!
  def index
    @expenses = Group.find(params[:group_id]).expenses.order(created_at: :desc)
    @total = 0
    @expenses.each do |expense|
      @total += expense.amount
    end
  end

  def new
    @expense = Expense.new
    @current_group = Group.find(params[:group_id])
    @groups = Group.all.where(user: current_user).map do |group|
      group.name
    end
  end
  
  def create
    group = Group.where(name: params[:expense][:group])
    expense = Expense.new(expense_params)
    expense.user = current_user
    flash[:message] = if expense.save then
      group.first.expenses << expense
      "Expense created sucessfully"
    else
      "Expense could not be created"
    end
    redirect_to group_expense_index_path(group.first.id)
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount)
  end
end