class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @post = Post.page(params[:page])
    @post_all = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path,notice: "投稿を削除しました"
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title,:body,:image,:address,:latitude,:longitude)
  end
  
end
