class GroupController < ApplicationController
  before_action :authenticate_user!
  def index
    @groups = Group.includes([:expenses]).where(user: current_user)
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

  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
