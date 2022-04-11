class ApplicationController < ActionController::Base
  devise_group :user_or_admin, contains: [:user, :admin]
  before_action :authenticate_user_or_admin!,except: [:top, :about, :index, :show, :create]

  def after_sign_in_path_for(resource)
    user_users_path

  end

  def after_sign_out_path_for(resource)
    user_homes_top_path
  end

  private

  def configure_permitted_parameters
    devese_parameter_sanitizer.permit(:sign_up,keys:[:email])
  end
end
