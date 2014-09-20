class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, :user_type, :name, [course_ids: []])}

    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:email, :password, :password_confirmation, :user_type, :current_password, :name, [course_ids: []])}
  end

  def index
    @users = User.all
  end


  def new
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to locations_path, :alert => exception.message
  end

end

