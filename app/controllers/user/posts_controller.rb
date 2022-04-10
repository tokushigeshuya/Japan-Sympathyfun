class User::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def index
    @post = Post.all
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user == current_user
      render :edit
    else
      redirect_to user_posts_path
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to user_posts_path
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to user_posts_path(@post.id)
    else
      render edit_user_post_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_posts_path
  end

   private

  def post_params
    params.require(:post).permit(:title, :image, :body)
  end
end
