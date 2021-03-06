class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_user!
  protect_from_forgery prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?
  
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in) do |user_params|
        user_params.permit(:username, :email)
      end
    end
end   
