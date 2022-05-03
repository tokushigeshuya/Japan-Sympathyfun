class User::UsersController < ApplicationController
  
  before_action :authenticate_user!, except: [:index]

  def index
    @user = User.page(params[:page])
    @rank = User.find(Relationship.group(:follower_id).order('count(follower_id) DESC').limit(3).pluck(:follower_id))
  end

  def show
    @user = User.find(params[:id])
    @post = @user.post.page(params[:page])

  end

  def edit
    @user = User.find(params[:id])
  end

  def unsubscribe
    @user = current_user
  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path,notice: "退会しました！"
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_user_path(current_user),notice: "ユーザー情報を更新しました！"
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:introduction,:email,:profile_image)
  end
end
