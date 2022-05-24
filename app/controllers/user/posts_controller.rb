class User::PostsController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]

  def new
    @post = Post.new
  end

  def index
    if params[:tag_name]
      @post = Post.tagged_with("#{params[:tag_name]}")
    else
      @post = Post.page(params[:page])
    end

    @posts = Post.where(user_id: [*current_user.following_ids])

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
    if @post.save
      redirect_to user_posts_path,notice: "投稿完了！"
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to user_post_path(@post.id), notice: "投稿内容を更新しました。"
    else
      render edit_user_post_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_posts_path,notice: "投稿を削除しました"
  end

   private

  def post_params
    params.require(:post).permit(:title, :image, :body,:address,:latitude,:longitude,:tag_list)
    #tag_list を追加
  end

end
