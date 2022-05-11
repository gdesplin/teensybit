class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend

  private

  def authenticate_admin!
    redirect_to :root unless current_user&.admin?
  end

  def authenticate_provider!
    redirect_to :root unless current_user&.provider?
  end

  def authenticate_guardian!
    redirect_to :root unless current_user&.guardian?
  end

  def dashboard_path
    @dashboard_path = current_user.guardian? ? [:guardian_dashboard, :daycares] : [:provider_dashboard, :daycares]
  end
  helper_method :dashboard_path
end
