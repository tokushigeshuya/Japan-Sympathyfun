class Admin::UsersController < ApplicationController

  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page])
    @user_all = User.all
  end

  def show
    @user = User.find(params[:id])
    @post = @user.post
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id),notice: "ユーザー情報を更新しました！"
    else
      render edit
    end

  end

  private

  def user_params
    params.require(:user).permit(:name,:introduction,:email,:profile_image,:is_deleted)
  end

end
