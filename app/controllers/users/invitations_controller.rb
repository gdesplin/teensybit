class Users::InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters, only: [:create, :update]

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: %i[name address address_two city state zip phone kind daycare_id])
  end

  def after_accept_path_for(resource)
    dashboard_daycares_path
  end

end
