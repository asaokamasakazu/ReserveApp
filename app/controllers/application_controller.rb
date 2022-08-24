class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_q

  protect_from_forgery
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:image_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:introduction])
  end

  private

  def set_q
    @q = Room.ransack(params[:q])
  end
end
