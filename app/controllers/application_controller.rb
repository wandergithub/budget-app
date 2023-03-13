class ApplicationController < ActionController::Base
  before_action :render_loading_page, if: -> { sleep_time_exceeded? }

  layout 'loading', only: [:render_sleeping]
  
  include Devise::Controllers::Helpers

  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :current_password)
    end
  end

  private

  def sleep_time_exceeded?
    # Initialize `app_initialized_time` when the application starts up
    @app_initialized_time ||= Time.now

    # Check if the current time is more than 60 seconds (or any desired time limit) after
    # the application was initialized
    Time.now > (@app_initialized_time + 60)
  end

  def render_loading_page
    render html: "", layout: "loading"
  end
end
