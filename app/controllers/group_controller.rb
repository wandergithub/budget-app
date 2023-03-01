class GroupController < ApplicationController
  before_action :authenticate_user!
  def index
    # User Income
    @income = current_user.income || '0.00'

    # Groups
    @groups = Group.includes([image_attachment: [:blob]]).where(user: current_user)

    # Overall Expenses
    @overall_expenses = 0
    @groups.each do |group|
      @overall_expenses += group.total_expenses
    end
  end

  def new
    @group = Group.new
  end

  def create
    group = Group.new(group_params)
    group.user = current_user

    if group.save
      flash[:message] = 'group saved!'
      redirect_to group_index_path
    else
      flash[:message] = 'group could not be saved!'
      redirect_to new_group_path
    end
  end

  def update
    group = Group.find(params[:id])
    group.update(group_params)

    redirect_to group_index_path
  end

  def edit
    group = Group.find(params[:id])
    @current_name = group.name
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to '/group'
  end

  def set_income
    current_user.update(income: income_param)
  end

  private

  def income_param
    params.require(:income)
  end

  def group_params
    params.require(:group).permit(:name, :image)
  end
end
