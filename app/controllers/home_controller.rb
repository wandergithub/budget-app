class HomeController < ApplicationController
  def index
    redirect_to group_index_path if user_signed_in?
  end

  def render_sleeping
    render layout: false
  end
end
