class ApplicationController < ActionController::Base
  include Pundit
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
end
