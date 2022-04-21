class ApplicationController < ActionController::Base
  devise_group :user_or_admin, contains: [:user, :admin]
  # before_action :authenticate_user_or_admin!,except: [:top, :about, :index, :show, :create]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  def after_sign_in_path_for(resource)
    root_path

  end

  def after_sign_out_path_for(resource)
    root_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:email])
  end

  def set_search
    @q = Post.ransack(params[:q])
    @items = @q.result(distinct: true)
  end
end
