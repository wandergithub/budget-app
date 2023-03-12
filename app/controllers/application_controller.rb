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
    (Time.now - File.mtime('/tmp/app-initialized')).to_i > 30
  end

  def render_loading_page
    render file: Rails.public_path.join('loading.html'), layout: false, status: :service_unavailable
  end
end
