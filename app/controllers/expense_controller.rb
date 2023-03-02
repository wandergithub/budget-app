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
    @groups = Group.all.where(user: current_user).map(&:name)
  end

  def create
    group = Group.where(name: params[:expense][:group])
    expense = Expense.new(expense_params)
    expense.user = current_user
    flash[:message] = if expense.save
                        group.first.expenses << expense
                        'Expense created sucessfully'
                      else
                        'Expense could not be created'
                      end
    redirect_to group_expense_index_path(group.first.id)
  end

  def destroy
    expense = Expense.find(params[:id])
    expense.destroy
    redirect_to group_expense_index_path(params[:group_id])
  end

  def update
    expense = Expense.find(params[:id])
    expense.update(expense_params)
    redirect_to group_expense_index_path(params[:group_id])
  end

  def edit
    @current_group = Group.find(params[:group_id])
    @groups = Group.all.where(user: current_user).map(&:name)
    expense = Expense.find(params[:id])
    @current_name = expense.name
    @current_amount = expense.amount
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount)
  end
end
