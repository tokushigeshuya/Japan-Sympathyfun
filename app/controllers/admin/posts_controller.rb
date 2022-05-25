class Admin::PostsController < ApplicationController

  before_action :authenticate_admin!

  def index
    
    #タグ絞り込み
    if params[:tag_name]
      @post = Post.tagged_with("#{params[:tag_name]}").page(params[:page]).per(4)
    else
      @post = Post.page(params[:page]).per(6)
    end
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
